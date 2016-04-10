
namespace :elastic do

  desc "Import data to ElasticSearch"
  task :import do
    Article.import force: true
  end

end

