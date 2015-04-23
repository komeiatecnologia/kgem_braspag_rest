module KBraspag
  module WebService
    require 'lib/braspag/webservice/rest_client'
    require 'lib/braspag/response/simplified_credit_card'
    require 'lib/helpers/configuration'

    class SimplifiedCreditCard
      extend KBraspag::Configuration

      define_setting :SIMPLIFIED_CREDIT_CARD_RESOURCE, "/v2/sales/"

      def initialize
        @rest_client = KBraspag::WebService::RestClient.new
      end

      def send_request(scc_request)
        @rest_client.post(@@SIMPLIFIED_CREDIT_CARD_RESOURCE, scc_request.to_braspag_hash).request
      end
    end
  end
end
