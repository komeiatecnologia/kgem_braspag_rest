module Braspag
  module Payment
    require 'lib/braspag/webservice/simplified_credit_card'
    require 'lib/braspag/model/request/simplified_credit_card'

    class SimplifiedCreditCard < Braspag::Model::Request::SimplifiedCreditCard

      attr_reader :success_request, :errors

      def initialize
        super
        @success_request = false
        @errors = nil
      end

      def pay
        send_request if valid_for_send?
      end

      private
      def response_format(response)
        Braspag::Model::Response::SimplifiedCreditCard.new(response.body)
      end

      def valid_for_send?
        @payment.valid? && @customer.valid?
      end

      def send_request
        @ws_client ||= Braspag::WebService::SimplifiedCreditCard.new
        @ws_client.send_request(self)
      end
    end
  end
end
