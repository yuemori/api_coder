require 'faker'
require 'active_support'
require 'active_support/core_ext'
require 'api_coder/attribute'
require 'api_coder/enum'
require 'api_coder/route'
require 'api_coder/version'
require 'api_coder/parser'
require 'api_coder/registry'
require 'api_coder/type'

module APICoder
  class << self
    def enum(name, &block)
      enum = Parser::EnumParser.new(name).parse(&block)

      enums.register name, enum
    end

    def enums
      @enums ||= Registry.new(:Enum)
    end

    def route(&block)
      Parser::RouteParser.new.parse(&block).each do |route|
        routes.register route.name, route
      end
    end

    def routes
      @routes ||= Registry.new(:Route)
    end

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
