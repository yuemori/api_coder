module APICoder
  class Request
    attr_reader :enum

    def initialize(enum)
      @enum = enum
    end

    def valid?(hash)
      enum.valid?(hash)
    end

    def attributes
      enum.attributes || []
    end

    def examples
      enum.examples
    end
  end
end
