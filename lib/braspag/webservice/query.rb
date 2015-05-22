module KBraspag
  module WebService
    # require 'lib/braspag/webservice/rest_client'
    # require 'lib/braspag/response/query'

    class Query
      def initialize
        @rest_client = KBraspag::WebService::RestClient.new
      end

      def send_request(query)
        if query.payment_id
          req = @rest_client.get(url_payment_id(query.payment_id))
        else
          req = @rest_client.get(url_merchant_id(query.merchant_order_id))
        end
        format_response(req.request)
      end

      private
      def url_payment_id(payment_id)
        "#{KBraspag.query_url}#{KBraspag.query_resource}#{payment_id}"
      end

      def url_merchant_id(merchant_order_id)
        url = "#{KBraspag.query_url}"
        url << "#{KBraspag.query_resource}"
        url << "?merchantOrderId=#{merchant_order_id}"
        url
      end

      def format_response(response)
        KBraspag::Response::Query.build_response(response)
      end
    end
  end
end
