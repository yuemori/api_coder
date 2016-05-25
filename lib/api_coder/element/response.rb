module APICoder
  module Element
    class Response
      attr_reader :name

      def initialize(namespace, name)
        @namespace = namespace
        @name = name
      end

      def add_param(name, options = {})
        param = Element::Param.new(name, options)

        params << param
      end

      def params
        @params ||= []
      end
    end
  end
end
