require 'thor'
require 'api_coder/commands/init'
require 'api_coder/commands/mock'
require 'api_coder/commands/generator'
require 'api_coder/commands/install_plugin'

module APICoder
  class CLI < Thor
    register(
      Commands::Init,
      'init',
      'init',
      'initialize of api_coder'
    )

    register(
      Commands::Mock,
      'mock',
      'mock config.rb',
      'run mock server from api_coder'
    )

    register(
      Commands::Generator,
      'generate',
      'generate COMMAND',
      'generate files from api_coder'
    )

    register(
      Commands::InstallPlugin,
      'plugin:install',
      'plugin:install plugin_name',
      'install plugin'
    )
  end
end
