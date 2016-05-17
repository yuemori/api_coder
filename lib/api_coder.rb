require 'faker'
require 'active_support'
require 'active_support/core_ext'
require 'api_coder/version'
require 'api_coder/parser'
require 'api_coder/registry'
require 'api_coder/resource'
require 'api_coder/type'

module APICoder
  class << self
    def define(namespace, &block)
      resources.register(namespace, APICoder::Parser.parse(namespace, &block))
    end

    def find_link(namespace, name)
      resources.fetch(namespace).link(name)
    end

    def find_attribute(namespace, name)
      resources.fetch(namespace).attribute(name)
    end

    def find_struct(namespace, name)
      resources.fetch(namespace).struct(name)
    end

    def resources
      @resources ||= Registry.new(:Resource)
    end
  end
end
