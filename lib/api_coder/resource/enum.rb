module APICoder
  class Resource
    class Enum
      attr_reader :namepsace, :name, :params

      def initialize(namespace, name, params)
        @name = name
        @namespace = namespace
        @params = params
      end

      def to_param
        params.map { |name| APICoder.find_param(namespace, name) }
      end
    end
  end
end
