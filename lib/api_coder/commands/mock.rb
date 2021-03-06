module APICoder
  module Commands
    class Mock < Thor::Group
      argument :config_file

      class_option :port, type: :numeric, default: 8080
      class_option :host, type: :string, default: '0.0.0.0'

      def mock
        require 'rack'
        require 'rack/api_coder'

        load config_file

        Rack::Server.start(app: app, Port: options[:port], Host: options[:host])
      end

      private

      def app
        Rack::Builder.new do
          use Rack::APICoder::RequestValidator
          use Rack::APICoder::Mock
          run ->(_env) { [404, {}, [{ id: 'not_found', message: 'link not found' }.to_json]] }
        end
      end
    end
  end
end
