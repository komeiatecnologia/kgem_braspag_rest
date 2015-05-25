module KBraspag
  module WebService
    # require 'lib/braspag/webservice/rest_client'
    # require 'lib/braspag/response/query'

    class Query
      def initialize
        @rest_client = KBraspag::WebService::RestClient.new
      end

      def send_request(query)
        return send_payment_id(query) if query.payment_id
        return send_merchant_order_id(query) if query.merchant_order_id
      end

      private
      def send_payment_id(query)
        req = @rest_client.get(url_payment_id(query.payment_id))
        format_response(req)
      end

      def send_merchant_order_id(query)
        req = @rest_client.get(url_merchant_order_id(query.merchant_order_id))
        format_response(req)
      end

      def url_payment_id(payment_id)
        "#{KBraspag.query_url}#{KBraspag.query_resource}#{payment_id}"
      end

      def url_merchant_order_id(merchant_order_id)
        url = "#{KBraspag.query_url}"
        url << "#{KBraspag.query_resource}"
        url << "?merchantOrderId=#{merchant_order_id}"
        url
      end

      def format_response(response)
        # KBraspag::Response::Query.build_response(response)
      end
    end
  end
end
