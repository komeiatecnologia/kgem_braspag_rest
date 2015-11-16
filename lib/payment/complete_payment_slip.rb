module KBraspag
  module Payment



    class CompletePaymentSlip < KBraspag::Request::CompletePaymentSlip

      def pay
        send_request if valid_?
      end

      private
      def send_request
        @ws_client ||= KBraspag::WebService::CompletePaymentSlip.new
        @ws_client.send_request(self)
      end
    end
  end
end
