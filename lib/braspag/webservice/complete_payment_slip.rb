module KBraspag
  module Webservice
    require 'lib/braspag/webservice/rest_client'
    require 'lib/braspag/response/complete_payment_slip'
    require 'lib/helpers/configuration'

    class CompletePaymentSlip
      extend KBraspag::Configuration

      define_setting :COMPLETE_PAYMENT_SLIP_RESOURCE, "/v2/sales/"

      def initialize
        @rest_client = KBraspag::Webservice::RestClient.new
      end

      def send_request(cps_request)
        @rest_client.post(@@COMPLETE_PAYMENT_SLIP_RESOURCE, cps_request.to_braspag_hash).request
      end
    end
  end
end
