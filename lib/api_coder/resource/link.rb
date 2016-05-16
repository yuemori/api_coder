module APICoder
  class Resource
    class Link
      attr_reader :name, :namespace, :title, :description, :path, :method

      def initialize(attributes)
        attributes.each do |key, value|
          send("#{key}=", value)
        end
      end

      def request_params
        APICoder.find_enum(namespace, request.enum_name).to_params
      end

      def response_params
        options = response.options
        enum_name = response.enum_name

        if options[:array]
          [APICoder.find_enum(namespace, enum_name).to_params]
        else
          APICoder.find_enum(namespace, enum_name).to_params
        end
      end

      private

      attr_writer :name, :namespace, :title, :description, :path, :method, :request, :response
    end
  end
end
