require 'api_coder/resource/link'
require 'api_coder/resource/attribute'
require 'api_coder/resource/struct'
require 'api_coder/resource/request'
require 'api_coder/resource/response'

module APICoder
  class Resource
    attr_accessor :namespace, :description

    def initialize(attributes)
      attributes.each do |key, value|
        public_send("#{key}=", value)
      end
    end

    def attribute(name)
      attribute_registry.fetch(name)
    end

    def struct(name)
      struct_registry.fetch(name)
    end

    def link(name)
      link_registry.fetch(name)
    end

    def links
      link_registry.values
    end

    %i(attribute struct link).each do |method_name|
      define_method "#{method_name}s=" do |objects|
        objects.each do |object|
          registry = send("#{method_name}_registry")
          registry.register object.name, object
        end
      end
    end

    def attribute_registry
      @attribute_registry ||= Registry.new(:Attribute)
    end

    def struct_registry
      @struct_registry ||= Registry.new(:Struct)
    end

    def link_registry
      @link_registry ||= Registry.new(:Link)
    end
  end
end
