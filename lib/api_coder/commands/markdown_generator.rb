module APICoder
  module Commands
    class MarkdownGenerator < Thor::Group
      include Thor::Actions

      argument :config_file
      class_option :output, type: :string, alias: 'o', default: 'api.md'

      source_root File.expand_path('../templates', __FILE__)

      def load_config
        load config_file
      end

      def create_markdown
        template 'api.md.erb', options[:output]
      end
    end
  end
end
