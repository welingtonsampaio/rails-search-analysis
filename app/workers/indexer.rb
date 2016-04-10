class Indexer
  include Sidekiq::Worker
  sidekiq_options queue: 'elasticsearch', retry: false

  def perform(operation, record_id)
    logger.debug [operation, "ID: #{record_id}"]

    case operation.to_s
      # Create and update index in ElasticSearch
      when /index/
        record = Article.find_by_id(record_id)
        Elasticsearch::Model.client.index  index: Article.index_name, type: 'article', id: record.id, body: record.as_indexed_json

      # Delete the index in ElasticSearch
      when /delete/
        Elasticsearch::Model.client.delete index: Article.index_name, type: 'article', id: record_id
      else raise ArgumentError, "Unknown operation '#{operation}'"
    end
  end
end