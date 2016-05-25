module APICoder
  module Element
    class Method
      PERMITTED_METHODS = %w(GET POST PUT DELETE).freeze

      delegate :GET?, :POST?, :PUT?, :DELETE?, to: :method

      def initialize(method)
        raise ArgumentError.new, "#{method} is not supported method" unless PERMITTED_METHODS.include? method.to_s

        @method = method.to_s.inquiry
      end

      private

      attr_reader :method
    end
  end
end
