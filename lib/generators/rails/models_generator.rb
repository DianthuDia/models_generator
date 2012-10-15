# coding: utf-8

require 'rails/generators'
require 'rails/generators/active_record/model/model_generator'

class Rails::ModelsGenerator < ActiveRecord::Generators::ModelGenerator
  source_root File.expand_path('../templates', __FILE__)
  
  # to use parent generator without args
  remove_argument :name
  def initialize(args, *options)
    self.name = args.pop || 'base'
    super
  end
  
  # don't create migration file
  def create_migration_file; end
  
  def create_model_file
    tables = ActiveRecord::Base.connection.tables - [ActiveRecord::Migrator.schema_migrations_table_name]
    
    tables.each do |tbl_name|
      clear_instance_variables pluralize_table_names? ? tbl_name.singularize : tbl_name
      template 'model.rb.erb', File.join('app/models', class_path, "#{file_name}.rb")
      template 'model_spec.rb.erb', File.join('spec/models', class_path, "#{file_name}_spec.rb")
    end
  end
  
  remove_hook_for :test_framework
  
  protected
    def master?
      columns = ActiveRecord::Base.connection.columns(table_name).map(&:name)
      ModelsGenerator.config.master_attrs.all? {|c| columns.include? c}
    end

    # clear memoization without @options
    def clear_instance_variables(name)
      instance_variables.each{|v| remove_instance_variable v unless v.eql? :@options}
      initialize [name], @options      
    end
end
