class Article < ActiveRecord::Base
  include Elasticsearch::Model

  has_many :search_consultings

  after_save { Indexer.perform_async(:index, self.id) }
  after_destroy { Indexer.perform_async(:delete, self.id) }

  # Object returned to ElasticSearch to indexed.
  #
  # @param options [Hash] Merged objeto send to `as_json` method
  #
  # @return [Hash]
  def as_indexed_json(options={})
    as_json({only: [:title]}.merge(options)).merge({
                                                       click: search_consultings.count
                                                   })
  end

  # Responsible for performing research with the score
  # ElasticSearch to find the best result for the search.
  #
  # @param term [String] Term of search. eg.: "How can I"
  # @param options [Hash] Parameters to consulting, options relevants: per_page | page
  #
  # @return [Elasticsearch::Model::Response::Response]
  def self.s(term, options={})
    options[:size] = options.delete(:per_page) || 10
    options[:from] = options[:size] * ((options.delete(:page) || 1)-1)
    options[:query] = {
        function_score: {
            query: {
                query_string: {
                    query: "*#{term}*",
                    fields: ['title^2', '_all']
                }
            },
            functions: [
                {
                    field_value_factor: {
                        field: "click",
                        modifier: "log1p",
                        factor: 0.02
                    }
                }
            ],

            boost_mode: "sum"
        }
    }

    search options
  end
end
Article.index_name "zaez-railssearchanalysis-#{Rails.env}-article"