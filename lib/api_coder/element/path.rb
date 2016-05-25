module APICoder
  module Element
    class Path
      def initialize(path)
        raise ArgumentError.new, "#{path} is invalid path" unless path.start_with?('/')

        @path = path.gsub(%r{/\Z}, '')
      end
    end
  end
end
