module APICoder
  class Attribute
    attr_reader :name, :type

    def initialize(name, type)
      @name = name
      @type = Type.fetch(type).new
    end

    def example
      { name => type.example }
    end
  end
end
