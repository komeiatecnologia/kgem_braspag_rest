module KBraspag
  module WebService
    require 'lib/braspag/webservice/rest_client'
    require 'lib/braspag/response/simplified_credit_card'

    class SimplifiedCreditCard

      def initialize
        @rest_client = KBraspag::WebService::RestClient.new
      end

      def send_request(scc_request)
        req = @rest_client.post(url, scc_request.to_braspag_hash)
        format_response(req.request)
      end

      private
      def url
        @@URL ||= KBraspag.payment_url + KBraspag.simplified_credit_card_resource
      end

      def format_response(response)
        KBraspag::Response::SimplifiedCreditCard.build_response(response)
      end
    end
  end
end
