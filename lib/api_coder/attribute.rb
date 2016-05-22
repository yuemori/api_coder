module APICoder
  class Attribute
    def initialize(name, type)
      @name = name
      @type = Type.fetch(type).new
    end
  end
end
