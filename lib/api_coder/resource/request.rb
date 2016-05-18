module APICoder
  class Resource
    class Request
      PARAMS_IN_URL_PATTERN = /:[\w]+/

      attr_reader :namespace, :name

      def initialize(namespace, name, options)
        @namespace = namespace
        @name = name
        @options = options
      end

      def attributes
        @attributes ||= struct_attributes.concat(path_attributes)
      end

      private

      def struct
        APICoder.find_struct(namespace, options[:struct_name])
      end

      def struct_attributes
        struct.attributes
      end

      def attribute_names_from_path
        options[:path]&.scan(PARAMS_IN_URL_PATTERN)
      end

      def path_attributes
        attribute_names_from_path.map { |name| APICoder.find_attribute(namespace, name) }
      end
    end
  end
end
