module KBraspag
  module WebService



    class Query
      def initialize
        @rest_client = KBraspag::WebService::RestClient.new
      end

      def send_request(query)
        req = @rest_client.get(url_payment_id(query.payment_id))
        format_response(req.request)
      end

      private
      def url_payment_id(payment_id)
        "#{KBraspag.query_url}#{KBraspag.query_resource}#{payment_id}"
      end

      def format_response(response)
        KBraspag::Response::Query.build_response(response)
      end
    end
  end
end
