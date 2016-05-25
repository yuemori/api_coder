require 'faker'
require 'active_support'
require 'active_support/core_ext'
require 'api_coder/attribute'
require 'api_coder/enum'
require 'api_coder/route'
require 'api_coder/version'
require 'api_coder/parser'
require 'api_coder/request'
require 'api_coder/response'
require 'api_coder/registry'
require 'api_coder/type'

require 'api_coder/namespace'
require 'api_coder/element'

module APICoder
  class << self
    def load(file)
      Parser.new.load(file)
    end

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
  end
end
