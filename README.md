# Rails Search Analysis

Research analysis project. Analyzes the amount of valid research on existing articles.

Data seed from intercom.io [link](https://docs.intercom.io/search)


## Pre requirements

* Rails >= 4.x
* Bundler
* PostgreSql >= 8.2
* ElasticSearch >= 2.1


## Running

You must install the requirements, use the command:

```bash
bundle install
bundle exec rake db:create db:seed elastic:import
bundle exec guard
```

Access the project in [http://localhost:3000/](http://localhost:3000/)


