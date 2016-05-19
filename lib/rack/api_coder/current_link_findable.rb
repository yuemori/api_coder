module Rack
  module APICoder
    module CurrentLinkFindable
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
