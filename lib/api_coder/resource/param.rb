module APICoder
  class Resource
    class Param
      attr_reader :namespace, :name, :type

      def initialize(namespace, name, type)
        @namespace = namespace
        @name = name
        @type = Type.fetch(type).new
      end

      def to_example
        { name => type.example }
      end
    end
  end
end
