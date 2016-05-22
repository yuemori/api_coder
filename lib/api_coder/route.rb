module APICoder
  class Route
    PARAMS_IN_URL_PATTERN = /:[\w]+/

    attr_reader :path, :method, :description, :title, :return_type

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

    private

    attr_writer :description, :title, :params, :return_type
  end
end
