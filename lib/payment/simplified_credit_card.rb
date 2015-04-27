module KBraspag
  module Payment
    require 'lib/braspag/webservice/simplified_credit_card'
    require 'lib/braspag/request/simplified_credit_card'

    class SimplifiedCreditCard < KBraspag::Request::SimplifiedCreditCard

      def pay
        send_request if valid_for_send?
      end

      private
      def valid_for_send?
        @payment.valid? && @customer.valid?
      end

      def send_request
        @ws_client ||= KBraspag::WebService::SimplifiedCreditCard.new
        @ws_client.send_request(self)
      end
    end
  end
end
