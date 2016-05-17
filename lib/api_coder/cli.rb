require 'api_coder/commands/init'
require 'api_coder/commands/mock'

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
  end
end
