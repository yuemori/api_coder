module APICoder
  module Parser
    class ResourceParser
      def initialize(namespace)
        properties[:namespace] = namespace
      end

      def parse(&block)
        instance_eval(&block)
        APICoder::Resource.new(properties)
      end

      private

      def namespace
        properties[:namespace]
      end

      def properties
        @properties ||= {}
      end

      %i(title description).each do |method_name|
        define_method method_name do |value|
          properties[method_name] = value
        end
      end

      def attribute(name, type)
        attributes << APICoder::Resource::Attribute.new(namespace, name, type)
      end

      def attributes
        properties[:attributes] ||= []
      end

      def struct(name, attributes)
        struct = APICoder::Resource::Struct.new(namespace, name, attributes)

        structs << struct
      end

      def structs
        properties[:structs] ||= []
      end

      def link(name, &block)
        link = LinkParser.new(namespace, name).parse(&block)

        links << link
      end

      def links
        properties[:links] ||= []
      end

      def registry_name(suffix)
        "#{namespace}_#{suffix}".camelize.to_sym
      end
    end
  end
end
