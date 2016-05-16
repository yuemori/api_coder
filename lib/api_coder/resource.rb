require 'api_coder/resource/link'

module APICoder
  class Resource
    attr_reader :name, :description

    def initialize(attributes)
      attributes.each do |key, value|
        send("#{key}=", value)
      end
    end

    private

    attr_writer :name, :description, :links, :enums, :params
  end
end
