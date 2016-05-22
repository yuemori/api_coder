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

    def name
      method.downcase + path
    end

    def pattern
      %r{^#{path.gsub(PARAMS_IN_URL_PATTERN, '.+')}\/?$}
    end

    def valid_params?(hash)
      request.valid?(hash)
    end

    private

    attr_writer :description, :title, :request, :response
  end
end
