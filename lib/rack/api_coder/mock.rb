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

          if current_link
            dummy_response
          else
            @app.call(env)
          end
        end

        def dummy_response
          [status, {}, [dummy_body]]
        end

        def status
          method == 'POST' ? 201 : 200
        end

        def response_examples
          current_link.response.examples
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

        def current_link
          @current_link ||= begin
            ::APICoder.resources.each do |resource|
              resource.links.each do |link|
                return link if link.request?(method: method, path: path)
              end
            end

            nil
          end
        end
      end
    end
  end
end
