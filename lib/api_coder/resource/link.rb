module APICoder
  class Resource
    class Link
      attr_accessor :name, :namespace, :title, :description, :path, :method, :request, :response

      def initialize(attributes)
        attributes.each do |key, value|
          public_send("#{key}=", value)
        end
      end
    end
  end
end
