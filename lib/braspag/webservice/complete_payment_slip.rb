module KBraspag
  module WebService



    class CompletePaymentSlip

      def initialize
        @rest_client = KBraspag::WebService::RestClient.new
      end

      def send_request(cps_request)
        req = @rest_client.post(url, cps_request.to_braspag_hash)
        format_response(req.request)
      end

      def format_response(response)
        KBraspag::Response::CompletePaymentSlip.build_response(response)
      end

      private
      def url
        @@URL ||= KBraspag.payment_url + KBraspag.complete_payment_slip_resource
      end
    end
  end
end
