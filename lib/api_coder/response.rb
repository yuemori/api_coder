module APICoder
  class Response
    attr_reader :enum

    def initialize(enum, options)
      @enum = enum
      @options = options
    end

    def examples
      enum.examples
    end
  end
end
