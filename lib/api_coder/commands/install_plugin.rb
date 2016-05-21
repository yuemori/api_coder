module APICoder
  module Commands
    class InstallPlugin < Thor::Group
      include Thor::Actions

      argument :plugin_name

      def check_binstubs
        unless File.exist? 'bin/api_coder'
          puts 'bin/api_coder is missing. Please execute `api_coder install`'
          exit
        end
      end

      def install_plugin
        begin
          require "api_coder/#{plugin_name}"
        rescue LoadError
          puts "Plugin 'api_coder/#{plugin_name}' is missing in load path"
          exit
        end

        inject_into_file 'bin/api_coder', "require 'api_coder/#{plugin_name}'", after: "require 'api_coder'\n"
      end
    end
  end
end
