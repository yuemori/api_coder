module APICoder
  class Enum
    attr_reader :enum, :attributes

    def initialize(name, attributes, options)
      @name = name
      @attributes = attributes
      @options = options
    end

    def examples
      attributes.map(&:example).inject(:merge)
    end
  end
end
