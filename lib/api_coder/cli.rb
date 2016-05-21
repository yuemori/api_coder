require 'api_coder/commands/init'
require 'api_coder/commands/mock'
require 'api_coder/commands/install'
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
      Commands::Install,
      'install',
      'install',
      'install api_coder'
    )

    register(
      Commands::InstallPlugin,
      'install:plugin',
      'install:plugin plugin_name',
      'install api_coder plugin'
    )
  end
end
