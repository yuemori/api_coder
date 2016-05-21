module APICoder
  module Commands
    class Install < Thor::Group
      include Thor::Actions

      def binstubs
        `bundle binstubs api_coder`
      end
    end
  end
end
