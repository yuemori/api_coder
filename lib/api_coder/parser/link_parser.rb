module APICoder
  module Parser
    class LinkParser
      def parse(&block)
        instance_eval(&block)
        self
      end

      %i(title description path method request response).each do |method_name|
        define_method method_name do |value = nil|
          instance_variable_set("@#{method_name}", value) unless value.nil?
          instance_variable_get("@#{method_name}")
        end
      end
    end
  end
end
