module APICoder
  module Commands
    class Install < Thor::Group
      include Thor::Actions

      source_root File.expand_path('../templates', __FILE__)

      def binstubs
        copy_file 'api_coder', 'bin/api_coder'
      end
    end
  end
end
