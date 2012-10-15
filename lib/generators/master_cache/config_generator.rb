module ModelsGenerator::Generators
  class ConfigGenerator < Rails::Generators::Base
    source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

    desc <<DESC
Description:
  Copies models_generator configuration file to your application's initializer directory.
DESC

    def copy_config_file
      template 'models_generator_config.rb', 'config/initializers/models_generator_config.rb'
    end
  end
end
