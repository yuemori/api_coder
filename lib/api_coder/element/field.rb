module APICoder
  module Element
    class Field
      def initialize(name, type, options = {})
        @name = name
        @type = type
        @options = options
      end
    end
  end
end
