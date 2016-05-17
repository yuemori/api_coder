require 'api_coder/parser/resource_parser'
require 'api_coder/parser/link_parser'

module APICoder
  module Parser
    def self.parse(namespace, &block)
      ResourceParser.new(namespace).parse(&block)
    end
  end
end
