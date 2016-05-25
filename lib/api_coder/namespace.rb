module APICoder
  class Namespace
    attr_reader :name, :links, :types, :enums

    def initialize(name)
      @name = name
      @enums = []
      @types = []
      @links = []
    end

    def add_enum(enum)
      enums << enum
    end

    def add_link(link)
      links << link
    end

    def add_type(type)
      types << type
    end
  end
end
