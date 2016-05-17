require 'api_coder/commands/init'

module APICoder
  class CLI < Thor
    register(
      Commands::Init,
      'init',
      'init',
      'initialize of api_coder'
    )
  end
end
