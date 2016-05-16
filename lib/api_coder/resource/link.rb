module APICoder
  class Resource
    class Link
      attr_reader :name, :namespace, :title, :description, :path, :method, :request, :response

      def initialize(attributes)
        attributes.each do |key, value|
          send("#{key}=", value)
        end
      end

      def request_params
        APICoder.find_enum(namespace, request).to_params
      end

      def response_params
        APICoder.find_enum(namespace, response).to_params
      end

      private

      attr_writer :name, :namespace, :title, :description, :path, :method, :request, :response
    end
  end
end
