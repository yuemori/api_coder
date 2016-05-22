module APICoder
  module Commands
    class Init < Thor::Group
      include Thor::Actions

      source_root File.expand_path('../templates', __FILE__)

      def create_config_file
        copy_file 'config.rb', 'config.rb'
      end

      def create_binstub
        FileUtils.mkdir_p 'bin'
        template 'api_coder.erb', 'bin/api_coder'
        `chmod +x bin/api_coder`
      end
    end
  end
end
