module APICoder
  class Resource
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
          self.class.demodulize.underscore.to_sym
        end
      end

      class Integer < Value
        def example
          Faker::Number.number(3)
        end
      end

      class String < Value
        def example
          Faker::Internet.password
        end
      end

      class Float < Value
        def example
          Faker::Number.decimal(2)
        end
      end

      register(:integer, Type::Integer)
      register(:string, Type::String)
      register(:float, Type::Float)
    end
  end
end
