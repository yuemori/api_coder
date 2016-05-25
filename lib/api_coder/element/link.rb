module APICoder
  module Element
    class Link
      attr_reader :name, :path, :method

      def initialize(namespace, name)
        @namespace = namespace
        @name = name
      end

      def path=(path)
        @path = Element::Path.new(path)
      end

      def method=(method)
        @method = Element::Method.new(method)
      end

      def request
        @request ||= Element::Request.new(@namespace, name)
      end

      def response
        @response ||= Element::Response.new(@namespace, name)
      end
    end
  end
end
