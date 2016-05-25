require 'api_coder/parser/enum_parser'
require 'api_coder/parser/route_parser'
require 'api_coder/parser/dsl_parser'

module APICoder
  class Parser
    def load(file_path)
      string = File.open(file_path, &:read)
      file_name = File.basename(file_path, '.conf')
      namespace = Namespace.new(file_name)

      DslParser.new(namespace).parse(string)
    end
  end
end
