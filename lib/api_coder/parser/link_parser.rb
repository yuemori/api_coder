module APICoder
  module Parser
    class LinkParser
      def parse(&block)
        instance_eval(&block)
        self
      end

      %i(title description path method request).each do |method_name|
        define_method method_name do |value|
          instance_variable_set("@#{method_name}", value)
        end
      end

      Response = Struct.new(:value, :options)

      def response(value, options = {})
        @response = Response.new(value, options)
      end
    end
  end
end
