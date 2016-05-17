module APICoder
  class Resource
    class Response
      attr_reader :namespace, :name, :options

      def initialize(namespace, name, options)
        @namespace = namespace
        @name = name
        @options = options
      end

      def examples
        if options[:array]
          Array.new(5) { params_to_example }
        else
          params_to_example
        end
      end

      private

      def enum
        APICoder.find_enum(namespace, options.fetch(:enum_name))
      end

      def params
        enum.to_params
      end

      def params_to_example
        params.map(&:to_example).inject(:merge)
      end
    end
  end
end
