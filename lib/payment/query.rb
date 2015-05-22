module KBraspag
  module Payment
    #require 'lib/braspag/request/query'
    #require 'lib/braspag/webservice/query'

    class Query < KBraspag::Request::Query

      def consult
        send_request if valid_?
      end

      private
      def send_request
        @ws_client ||= KBraspag::WebService::Query.new
        @ws_client.send_request(self)
      end
    end
  end
end
