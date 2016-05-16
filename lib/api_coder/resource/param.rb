module APICoder
  class Resource
    class Param
      attr_reader :namespace, :name, :type

      def initialize(namespace, name, type)
        @namespace = namespace
        @name = name
        @type = type
      end
    end
  end
end
