require 'faker'
require 'active_support'
require 'active_support/core_ext'
require 'api_coder/version'
require 'api_coder/parser'
require 'api_coder/registry'
require 'api_coder/resource'

module APICoder
  class << self
    def define(name, &block)
      resources.register(name, APICoder::Parser.parse(name, &block))
    end

    def find_link(namespace, name)
      resources.fetch(namespace).link(name)
    end

    def find_param(namespace, name)
      resources.fetch(namespace).param(name)
    end

    def find_enum(namespace, name)
      resources.fetch(namespace).enum(name)
    end

    def resources
      @resources ||= Registry.new(:Resource)
    end
  end
end
