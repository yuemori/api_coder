module APICoder
  module Parser
    class LinkParser
      class << self
        def parse(&block)
          @link = APICoder::Resource::Link.new
          instance_eval(&block)
          @link
        end

        %i(title description path method request response).each do |method_name|
          define_method method_name do |value|
            @link.send("#{method_name}=", value)
          end
        end

        Request = Struct.new(:enum_name)

        def request(enum_name)
          @request = Request.new(enum_name)
        end

        Response = Struct.new(:enum_name, :options)

        def response(enum_name, options = {})
          @link.response = Response.new(enum_name, options)
        end
      end
    end
  end
end
