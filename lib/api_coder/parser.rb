require 'api_coder/parser/resource_parser'
require 'api_coder/parser/link_parser'

module APICoder
  module Parser
    def self.parse(name, &block)
      ResourceParser.new(name).parse(&block)
    end
  end
end
