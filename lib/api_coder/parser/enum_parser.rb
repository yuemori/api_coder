module APICoder
  class Parser
    class EnumParser
      attr_reader :name, :enum

      def initialize(name)
        @name = name
      end

      def parse(&block)
        instance_eval(&block)
        Enum.new(name, attributes, options)
      end

      def options
        @options ||= {}
      end

      def description(value)
        options[:description] = value
      end

      def attribute(name, type)
        attributes << Attribute.new(name, type)
      end

      def attributes
        @attributes ||= []
      end
    end
  end
end
