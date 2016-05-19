module Rack
  module APICoder
    class RequestValidator
      def initialize(app)
        @app = app
      end

      def call(env)
        Validator.new(env).validate!
        @app.call(env)
      rescue APIError => exception
        exception.to_rack_response
      end

      class APIError < StandardError
        def to_rack_response
          [status, headers, [body]]
        end

        private

        def id
          :internal_server_error
        end

        def status
          500
        end

        def headers
          { 'Content-Type' => 'application/json; charset=utf-8' }
        end

        def body
          JSON.pretty_generate(id: id, message: message) + "\n"
        end
      end

      class InvalidContentTypeError < APIError
        def exception(content_type = nil)
          super("invalid content type: #{content_type}")
        end

        def id
          :invalid_content_type
        end

        def status
          400
        end
      end

      class InvalidParameterError < APIError
        def exception(parameter = nil)
          super("invalid parameter: #{parameter}")
        end

        def id
          :invalid_parameter
        end

        def status
          400
        end
      end

      class LinkNotFound < APIError
        def exception(request = nil)
          super("link not found: #{request.request_method} #{request.path_info}")
        end

        def id
          :not_found
        end

        def status
          404
        end
      end

      class Validator
        include Rack::APICoder::CurrentLinkFindable

        def initialize(env)
          @request = Rack::Request.new(env)
        end

        def validate!
          return if method == 'GET'
          raise LinkNotFound.new, request unless current_link
          raise InvalidContentTypeError.new, content_type unless content_type_json?
          raise InvalidParameterError.new, body unless valid_body?
        end

        private

        attr_reader :request

        def body
          unless @body
            @body = request.body.read
            request.body.rewind
          end

          @body
        end

        def content_type
          request.content_type.split(';').first if request.content_type
        end

        def content_type_json?
          Rack::Mime.match?(content_type, 'application/json')
        end

        def parsed_body
          @parsed_body ||= JSON.parse(body)
        end

        def valid_body?
          current_link.request.match_param? parsed_body
        rescue JSON::JSONError
          false
        end
      end
    end
  end
end
