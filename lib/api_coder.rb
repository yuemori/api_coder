require 'active_support'
require 'active_support/core_ext'
require 'api_coder/version'
require 'api_coder/parser'
require 'api_coder/registry'

module APICoder
  class << self
    def define(name, &block)
      resources.register(name, APICoder::Parser.parse(&block))
    end

    def resources
      @resources ||= Registry.new(:Resource)
    end
  end
end
