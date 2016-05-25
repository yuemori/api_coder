module APICoder
  module Element
    class Param
      attr_reader :name

      def initialize(namespace, name, options = {})
        @namespace = namespace
        @name = name
        @options = options
      end
    end
  end
end
