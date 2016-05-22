module APICoder
  module Commands
    class InstallPlugin < Thor::Group
      argument :plugin_name

      include Thor::Actions

      source_root File.expand_path('../templates', __FILE__)

      def create_config_file
        begin
          require "api_coder/#{plugin_name}"
        rescue LoadError
          raise "api_coder/#{plugin_name} is not found in load path"
        end

        inject_into_file 'bin/api_coder', after: "### end point for api_coder plugins\n" do
          "require 'api_coder/#{plugin_name}'\n"
        end
      end
    end
  end
end
