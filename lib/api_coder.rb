require 'api_coder/version'
require 'api_coder/parser'
require 'active_support'
require 'active_support/core_ext'

module APICoder
  class << self
    def define(name, &block)
      resources[name] = APICoder::Parser.parse(&block)
    end

    def resources
      @resources ||= {}
    end
  end
end
