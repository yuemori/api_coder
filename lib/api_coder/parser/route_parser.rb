module APICoder
  module Parser
    class RouteParser
      def parse(&block)
        instance_eval(&block)
        @routes
      end

      def routes
        @routes ||= []
      end

      %w(get post update delete).each do |method|
        define_method method do |path, &block|
          routes << RouteEvaluator.new(path, method.upcase).parse(&block)
        end
      end

      class RouteEvaluator
        def initialize(path, method)
          @path = path
          @method = method
        end

        def options
          @options ||= {}
        end

        def parse(&block)
          instance_eval(&block)
          Route.new(@path, @method, options)
        end

        def title(value)
          options[:title] = value
        end

        def description(value)
          options[:description] = value
        end

        def params(enum_name)
          enum = APICoder.enums.fetch(enum_name)
          options[:params] = enum
        end

        Response = Struct.new(:enum, :options)

        def return_type(enum_name, response_options = {})
          enum = APICoder.enums.fetch(enum_name)
          options[:return_type] = Response.new(enum, response_options)
        end
      end
    end
  end
end
