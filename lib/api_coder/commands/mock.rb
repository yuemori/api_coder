module APICoder
  module Commands
    class Mock < Thor::Group
      argument :config_file

      class_option :port, type: :numeric, default: 8080
      class_option :host, type: :string, default: '0.0.0.0'

      def mock
        require 'rack'
        require 'rack/api_coder/mock'

        load config_file

        app = Rack::Builder.new do
          use Rack::APICoder::Mock
          run ->(_env) { [404, {}, [{ id: 'not_found', message: 'link not found' }.to_json]] }
        end

        Rack::Server.start(app: app, Port: 8080, Host: '0.0.0.0')
      end
    end
  end
end
