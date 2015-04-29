module KBraspag
  module WebService
    require 'lib/braspag/webservice/rest_client'
    require 'lib/braspag/response/complete_payment_slip'
    require 'lib/helpers/configuration'

    class CompletePaymentSlip
      extend KBraspag::Configuration

      define_setting :COMPLETE_PAYMENT_SLIP_RESOURCE, "/v2/sales/"

      def initialize
        @rest_client = KBraspag::WebService::RestClient.new
      end

      def send_request(cps_request)
        req = @rest_client.post(@@COMPLETE_PAYMENT_SLIP_RESOURCE, cps_request.to_braspag_hash)
        format_response(req.request)
      end

      def format_response(response)
        KBraspag::Response::CompletePaymentSlip.build_response(response)
      end
    end
  end
end
