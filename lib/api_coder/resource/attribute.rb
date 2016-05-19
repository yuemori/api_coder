module APICoder
  class Resource
    class Attribute
      attr_reader :namespace, :name, :type

      def initialize(namespace, name, type)
        @namespace = namespace
        @name = name
        @type = Type.fetch(type).new
      end

      def to_example
        { name => type.example }
      end

      def match?(value)
        type.match? value
      end
    end
  end
end
