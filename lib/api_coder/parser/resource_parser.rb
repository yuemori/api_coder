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

        params.register(name, param)
      end

      Enum = Struct.new(:name, :params)

      def enum(name, params)
        enum = Enum.new(name, params)

        enums.register(name, enum)
      end

      def link(name, &block)
        result = LinkParser.new.parse(&block)

        links.register(name, result)
      end

      def enums
        @enums ||= Registry.new(:Enum)
      end

      def params
        @params ||= Registry.new(:Param)
      end

      def links
        @links ||= Registry.new(:Link)
      end
    end
  end
end
