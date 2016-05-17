module APICoder
  module Parser
    class LinkParser
      def initialize(namespace, name)
        attributes[:namespace] = namespace
        attributes[:name] = name
      end

      def parse(&block)
        instance_eval(&block)
        APICoder::Resource::Link.new(attributes)
      end

      private

      def attributes
        @attributes ||= {}
      end

      %i(title description path method request response).each do |method_name|
        define_method method_name do |value|
          attributes[method_name] = value
        end
      end

      Request = Struct.new(:enum_name)

      def request(enum_name)
        attributes[:request] = Request.new(enum_name)
      end

      def response(enum_name, options = {})
        options[:enum_name] = enum_name

        attributes[:response] = Resource::Response.new(attributes[:namespace], attributes[:name], options)
      end
    end
  end
end
