require 'active_support/configurable'

module ModelsGenerator
  # Configures global settings for ModelsGenerator
  #   ModelsGenerator.configure do |config|
  #     config.all_name = :instances
  #   end
  def self.configure(&block)
    yield @config ||= ModelsGenerator::Configuration.new
  end

  # Global settings for ModelsGenerator
  def self.config
    @config
  end

  # need a Class for 3.0
  class Configuration #:nodoc:
    include ActiveSupport::Configurable
    config_accessor :master_attrs
    config_accessor :master_eval

    def param_name
      config.param_name.respond_to?(:call) ? config.param_name.call : config.param_name
    end

    # define param_name writer (copied from AS::Configurable)
    writer, line = 'def param_name=(value); config.param_name = value; end', __LINE__
    singleton_class.class_eval writer, __FILE__, line
    class_eval writer, __FILE__, line
  end

  # default
  configure do |config|
    begin
      require 'master_cache'
    rescue LoadError
      #do nothing
    end

    config.master_attrs = %w[name label value]
    config.master_eval = defined?(MasterCache)? 'master_cache' : ''
  end
end

