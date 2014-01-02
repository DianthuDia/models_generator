# ModelsGenerator

[![Build Status](https://secure.travis-ci.org/DianthuDia/models_generator.png)](http://travis-ci.org/DianthuDia/models_generator) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/DianthuDia/models_generator)

A model files generator plugin from migrate file

## Installation

Add this line to your application's Gemfile:

    gem 'models_generator', :groups => :development

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install models_generator

## Usage

### Basics

```ruby
class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table(:employees) {|t| t.string :name}
    create_table(:users) {|t| t.string :name}
  end
end
```

```bash
$ rake db:migrate
$ rails g models  # NOT 'model' ! 
     create  app/models/employee.rb
     create  spec/models/employee_spec.rb
     create  app/models/user.rb 
     create  spec/models/user_spec.rb
```

### General configuration options

You can configure the following default values by overriding these values using `ModelsGenerator.configure` method.

```ruby
master_attrs	# %w[name label value] by default
master_eval	# '' by default. If have 'master_cache' gem, 'master_cache'
```

If the table have value of master_attrs, model file include master_eval. For instance:

```ruby
class EmployeeType < ActiveRecord::Base
  master_cache
end
```

There's a handy generator that generates the default configuration file into config/initializers directory.
Run the following generator command, then edit the generated file.

`$ rails g models_generator:config`

## Recommend plugins
* [master_cache](https://rubygems.org/gems/master_cache)
	* 'models_generator' plugin integrated 'master_cache'

* [schema_plus](https://rubygems.org/gems/schema_plus)
* [schema_associations](https://rubygems.org/gems/schema_associations)
	* These plugin auto resolve relation (belongs_to, have_many...)

## Supported versions

* Ruby 1.8.7, 1.9.3, 2.1.0
* ActiveRecord 3.x, 4.x

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT License. Copyright 2012 DianthuDia.
