module APICoder
  class Route
    PARAMS_IN_URL_PATTERN = /:[\w]+/

    attr_reader :path, :method, :description, :title, :request, :response

    def initialize(path, method, options)
      @path = path
      @method = method

      options.each do |key, value|
        send("#{key}=", value)
      end
    end

    def status_code
      method == 'POST' ? 201 : 200
    end

    def name
      method.downcase + path
    end

    def pattern
      %r{^#{path.gsub(PARAMS_IN_URL_PATTERN, '.+')}\/?$}
    end

    def valid_params?(hash)
      request.valid?(hash)
    end

    def parameters
      @parameters ||= request.attributes + attributes_in_url
    end

    def responses
      @responses ||= response.attributes
    end

    private

    attr_writer :description, :title, :request, :response

    def attributes_in_url
      path.scan(PARAMS_IN_URL_PATTERN).map do |param|
        Attribute.new params, :integer, serializable: true
      end
    end
  end
end
