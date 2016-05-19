module APICoder
  class Resource
    class Struct
      attr_reader :namespace, :name

      def initialize(namespace, name, attribute_names)
        @name = name
        @namespace = namespace
        @attribute_names = attribute_names
      end

      def attributes
        @attributes ||= @attribute_names.map { |name| APICoder.find_attribute(namespace, name) }
      end

      def to_example
        attributes.map(&:to_example).inject(&:merge)
      end
    end
  end
end
