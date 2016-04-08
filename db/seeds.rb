# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

JSON.parse(File.read "#{Rails.root}/db/example_db.json")['articles'].each do |article|
  Article.find_or_create_by title: article['title'],
                            content: article['content']
end