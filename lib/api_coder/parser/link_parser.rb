module APICoder
  module Parser
    class LinkParser
      def initialize(namespace, name)
        properties[:namespace] = namespace
        properties[:name] = name
      end

      def parse(&block)
        instance_eval(&block)
        APICoder::Resource::Link.new(properties)
      end

      private

      def properties
        @properties ||= {}
      end

      %i(title description path method request response).each do |method_name|
        define_method method_name do |value|
          properties[method_name] = value
        end
      end

      Request = ::Struct.new(:struct_name)

      def request(struct_name)
        properties[:request] = Request.new(struct_name)
      end

      def response(params_name, options = {})
        options[:struct_name] = params_name

        properties[:response] = Resource::Response.new(properties[:namespace], properties[:name], options)
      end
    end
  end
end
