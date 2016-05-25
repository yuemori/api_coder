module APICoder
  module Element
    class Enum
      attr_reader :name

      include Enumerable

      def initialize(namespace, name, values)
        @namespace = namespace
        @name = name
        @values = values
      end

      def each(&block)
        @values.each(&block)
      end
    end
  end
end
