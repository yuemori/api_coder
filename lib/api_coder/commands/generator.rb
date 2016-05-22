require 'api_coder/commands/markdown_generator'

module APICoder
  module Commands
    class Generator < Thor
      register(
        Commands::MarkdownGenerator,
        'markdown',
        'generate markdown config_file_path',
        'generate markdown from api_coder. -o/--output output_path'
      )
    end
  end
end
