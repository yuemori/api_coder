module APICoder
  class Resource
    class Struct
      attr_reader :namespace, :name

      def initialize(namespace, name, attributes)
        @name = name
        @namespace = namespace
        @attributes = attributes
      end

      def to_example
        @attributes.map { |name| APICoder.find_attribute(namespace, name).to_example }.inject(&:merge)
      end
    end
  end
end
