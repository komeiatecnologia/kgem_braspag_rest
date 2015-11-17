module KBraspag
  module WebService
    class SimplifiedDebitCard

      def initialize
        @rest_client = KBraspag::WebService::RestClient.new
      end

      def send_request(sdc_request)
        req = @rest_client.post(url, sdc_request.to_braspag_hash)
        format_response(req.request)
      end

      private
      def url
        @@URL ||= KBraspag.payment_url + KBraspag.simplified_debit_card_resource
      end

      def format_response(response)
        KBraspag::Response::SimplifiedDebitCard.build_response(response)
      end
    end
  end
end
