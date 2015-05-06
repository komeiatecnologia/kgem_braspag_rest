module KBraspag
  module Payment
    require 'lib/braspag/webservice/complete_payment_slip'
    require 'lib/braspag/request/complete_payment_slip'


    class CompletePaymentSlip < KBraspag::Request::CompletePaymentSlip
      def pay
        send_request if valid?
      end

      private
      def send_request
        @ws_client ||= KBraspag::WebService::CompletePaymentSlip.new
        @ws_client.send_request(self)
      end
    end
  end
end
