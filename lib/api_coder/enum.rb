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

    def valid?(hash)
      hash = hash.symbolize_keys

      hash.all? do |key, value|
        attribute = attributes.find { |a| a.name == key }
        return false unless attribute

        attribute.valid?(value)
      end
    end
  end
end
