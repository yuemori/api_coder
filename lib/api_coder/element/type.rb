module APICoder
  module Element
    class Type
      attr_reader :name

      def initialize(namespace, name)
        @namespace = namespace
        @name = name
      end

      def add_field(name, type, options = {})
        field = Element::Field.new(name, type, options)

        fields << field
      end

      def add_enum(enum)
        enums << enum
      end

      def fields
        @fields ||= []
      end

      def enums
        @enums ||= []
      end
    end
  end
end
