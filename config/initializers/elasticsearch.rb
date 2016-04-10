es_hosts = [
      {
        host: 'localhost',
        port: '9200'
      }
    ]

Elasticsearch::Model.client = Elasticsearch::Client.new(hosts: es_hosts, logger: Logger.new(Rails.root.join('log','elasticsearch.log')))