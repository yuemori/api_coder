module APICoder
  class Resource
    class Link
      attr_accessor :name, :namespace, :title, :description, :path, :method, :request_options, :response_options

      def initialize(namespace, name, properties)
        @namespace = namespace
        @name = name

        properties.each do |key, value|
          public_send("#{key}=", value)
        end
      end

      def request
        @request ||= Resource::Request.new(namespace, name, request_options.merge(path: path, method: method))
      end

      def request?(method:, path:)
        request.match?(method: method, path: path)
      end

      def request_options
        @request_options ||= {}
      end

      def response
        @response ||= Resource::Response.new(namespace, name, response_options)
      end

      def response_options
        @response_options ||= {}
      end
    end
  end
end
