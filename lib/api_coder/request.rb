module APICoder
  class Request
    def initialize(enum)
      @enum = enum
    end

    def valid?(hash)
      @enum.valid?(hash)
    end
  end
end
