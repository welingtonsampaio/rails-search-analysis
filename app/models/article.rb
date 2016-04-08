class Article < ActiveRecord::Base
  include Elasticsearch::Model

  has_many :search_consultings

  after_save { Indexer.perform_async(:index, self.id) }
  after_destroy { Indexer.perform_async(:delete, self.id) }

  settings index: {number_of_shards: 2} do
    mappings dynamic: 'false' do
      indexes :title, analyzer: 'english', index_options: 'offsets'
    end
  end


  def as_indexed_json(options={})
    as_json(only: [:title]).merge({
                                      click: search_consultings.count
                                  })
  end

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
                        factor: 0.2
                    }
                }
            ],

            boost_mode: "sum"
        }
    }

    search options
  end


end
