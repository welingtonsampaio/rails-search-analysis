source 'https://rubygems.org'

ruby '2.1.5'

gem 'rails', '4.2.6'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'rabl'

# Sidekiq Worker Background
gem 'sidekiq'
gem 'sinatra', :require => nil

# Databases
gem 'pg'
gem 'elasticsearch-model', git: 'git://github.com/elasticsearch/elasticsearch-rails.git'
gem 'elasticsearch-rails', git: 'git://github.com/elasticsearch/elasticsearch-rails.git'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'rails_12factor', group: :production

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails'
end

group :development do
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'guard-rails'
  gem 'guard-bundler'
  gem 'guard-sidekiq'
  gem 'guard-rspec'
end

