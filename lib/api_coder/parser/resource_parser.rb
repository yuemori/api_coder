module APICoder
  module Parser
    class ResourceParser
      def initialize(name)
        attributes[:name] = name
      end

      def parse(&block)
        instance_eval(&block)
        APICoder::Resource.new(attributes)
      end

      private

      def attributes
        @attributes ||= {}
      end

      %i(title description).each do |method_name|
        define_method method_name do |value|
          attributes[method_name] = value
        end
      end

      Param = Struct.new(:name, :type)

      def param(name, type)
        param = Param.new(name, type)

        params << param
      end

      Enum = Struct.new(:name, :params)

      def enum(name, params)
        enum = Enum.new(name, params)

        enums << enum
      end

      def link(name, &block)
        link = LinkParser.new(attributes[:name], name).parse(&block)

        links << link
      end

      def params
        attributes[:params] ||= []
      end

      def enums
        attributes[:enums] ||= []
      end

      def links
        attributes[:links] ||= []
      end
    end
  end
end
