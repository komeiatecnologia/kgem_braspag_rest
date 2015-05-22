module KBraspag
  module WebService
    # require 'lib/braspag/webservice/rest_client'
    # require 'lib/braspag/response/cancel'

    class Cancel
      def initialize
        @rest_client = KBraspag::WebService::RestClient.new
      end

      def send_request(payment_id, amount = nil)
        req = @rest_client.put(url(payment_id, amount))
        format_response(req.request)
      end

      private
      def url(payment_id, amount)
        url = "#{KBraspag.payment_url}#{KBraspag.cancel_resource}"
        url << "#{payment_id}/void"
        url << "?amount=#{amount}" if amount
        url
      end

      def format_response(response)
        KBraspag::Response::Cancel.build_response(response)
      end
    end
  end
end
