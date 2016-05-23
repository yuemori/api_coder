module APICoder
  class Attribute
    attr_reader :name, :type

    def initialize(name, type, options = {})
      @name = name
      @type = Type.fetch(type).new
      @options = options
    end

    def example
      { name => type.example }
    end

    def valid?(value)
      type.valid?(value)
    end

    def serializable?
      @options.fetch(:serializable, false)
    end
  end
end
