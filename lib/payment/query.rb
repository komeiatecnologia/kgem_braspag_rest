module KBraspag
  module Payment
    #require 'lib/braspag/request/query'
    #require 'lib/braspag/webservice/query'

    class Query < KBraspag::Request::Query

      def consult(payment_id = nil)
        payment_id = payment_id unless payment_id.nil?
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
