module APICoder
  class Parser
    class DslParser
      def initialize(namespace)
        @namespace = namespace
      end

      def parse(string)
        instance_eval(string)
        @namespace
      end

      def type(name, &block)
        type = Element::Type.new(@namespace, name)
        TypeEvaluator.new(type).instance_eval(&block)

        @namespace.add_type(type)
      end

      def enum(name, values)
        enum = Element::Enum.new(@namespace, name, values)

        @namespace.add_enum(enum)
      end

      def link(name, &block)
        link = Element::Link.new(@namespace, name)
        LinkEvaluator.new(link).instance_eval(&block)

        @namespace.add_link(link)
      end

      class TypeEvaluator
        def initialize(type)
          @type = type
        end

        def field(name, type, options = {})
          @type.add_field(name, type, options)
        end

        def enum(name, values)
          enum = Element::Enum.new(@namespace, name, values)
          @type.add_enum(enum)
        end
      end

      class LinkEvaluator
        def initialize(link)
          @link = link
        end

        def path(path)
          @link.path = path
        end

        def method(method)
          @link.method = method
        end

        def request(&block)
          ParamEvaluator.new(@link.request).instance_eval(&block)
        end

        def response(&block)
          ParamEvaluator.new(@link.response).instance_eval(&block)
        end
      end

      class ParamEvaluator
        def initialize(data)
          @data = data
        end

        def param(name, options = {})
          @data.add_param(name, options)
        end
      end
    end
  end
end
