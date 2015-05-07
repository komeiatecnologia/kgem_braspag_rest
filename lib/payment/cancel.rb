module KBraspag
  module Payment
    # require 'lib/braspag/request/cancel'
    # require 'lib/braspag/webservice/cancel'

    class Cancel < KBraspag::Request::Cancel

      def cancel
        send_request if valid?
      end

      private
      def send_request
        @ws_client ||= KBraspag::WebService::Cancel.new
        @ws_client.send_request(@payment_id, @amount)
      end
    end
  end
end
