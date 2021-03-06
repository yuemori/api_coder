module APICoder
  class Type
    class << self
      delegate :register, :fetch, to: :type_registry

      private

      def type_registry
        @type_registry ||= Registry.new(:Type)
      end
    end

    class Value
      def name
        self.class.name.demodulize.underscore.to_sym
      end

      def valid?(value) # rubocop:disable Lint/UnusedMethodArgument
        true
      end
    end

    class Integer < Value
      def example
        Faker::Number.number(3)
      end

      def valid?(value)
        value.is_a? ::Integer
      end
    end

    class String < Value
      def example
        Faker::Internet.password
      end

      def valid?(value)
        value.is_a? ::String
      end
    end

    class Float < Value
      def example
        Faker::Number.decimal(2)
      end

      def valid?(value)
        value.is_a? ::Float
      end
    end

    register(:integer, Type::Integer)
    register(:string, Type::String)
    register(:float, Type::Float)
  end
end
