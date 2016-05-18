module APICoder
  module Parser
    class LinkParser
      def initialize(namespace, name)
        @namespace = namespace
        @name = name
      end

      def parse(&block)
        instance_eval(&block)
        APICoder::Resource::Link.new(namespace, name, properties)
      end

      private

      attr_accessor :namespace, :name

      def properties
        @properties ||= {}
      end

      %i(title description path method request response).each do |method_name|
        define_method method_name do |value|
          properties[method_name] = value
        end
      end

      def request(struct_name, options = {})
        options[:struct_name] = struct_name
        properties[:request_options] = options
      end

      def response(struct_name, options = {})
        options[:struct_name] = struct_name
        properties[:response_options] = options
      end
    end
  end
end
