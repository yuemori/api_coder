module Rack
  module APICoder
    class Mock
      def initialize(app)
        @app = app
      end

      def call(env)
        RequestHandler.new(@app).call(env)
      end

      class RequestHandler
        def initialize(app)
          @app = app
        end

        def call(env)
          @env = env

          if current_route
            dummy_response
          else
            @app.call(env)
          end
        end

        def current_route
          ::APICoder.routes.find do |route|
            route.pattern.match(path) && route.method == method
          end
        end

        def dummy_response
          [status, {}, [dummy_body]]
        end

        def status
          method == 'POST' ? 201 : 200
        end

        def response_examples
          current_route.response.examples
        end

        def dummy_body
          JSON.pretty_generate(response_examples) + "\n"
        end

        def request
          @request ||= Rack::Request.new(@env)
        end

        def method
          request.request_method
        end

        def path
          request.path_info
        end
      end
    end
  end
end
