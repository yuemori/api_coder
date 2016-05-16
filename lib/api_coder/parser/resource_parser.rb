module APICoder
  module Parser
    class ResourceParser
      def parse(&block)
        instance_eval(&block)
        self
      end

      def title(value = nil)
        @title = value unless value.nil?
        @title
      end

      def description(value)
        @description = value unless value.nil?
        @description
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
        result = LinkParser.new.parse(&block)

        links[name] = result
      end

      def enums
        @enums ||= []
      end

      def params
        @params ||= []
      end

      def links
        @links ||= {}
      end
    end
  end
end
