require 'api_coder/resource/link'
require 'api_coder/resource/enum'

module APICoder
  class Resource
    attr_reader :name, :description

    def initialize(attributes)
      attributes.each do |key, value|
        send("#{key}=", value)
      end
    end

    def param(name)
      params_registry.fetch(name)
    end

    def enum(name)
      enums_registry.fetch(name)
    end

    def link(name)
      links_registry.fetch(name)
    end

    private

    attr_writer :name, :description, :links, :enums, :params

    def params=(params)
      params.each do |param|
        params_registry.register param.name, param
      end
    end

    def params_registry
      @params_registry ||= Registry.new(:Param)
    end

    def enums=(enums)
      enums.each do |enum|
        enums_registry.register enum.name, enum
      end
    end

    def enums_registry
      @enums_registry ||= Registry.new(:Enum)
    end

    def links=(links)
      links.each do |link|
        links_registry.register link.name, link
      end
    end

    def links_registry
      @links_registry ||= Registry.new(:Link)
    end
  end
end
