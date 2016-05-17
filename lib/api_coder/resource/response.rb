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
          Array.new(5) { struct_examples }
        else
          struct_examples
        end
      end

      private

      def struct_examples
        APICoder.find_struct(namespace, options.fetch(:struct_name)).to_example
      end
    end
  end
end
