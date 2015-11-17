module KBraspag
  module Payment
    class SimplifiedDebitCard < KBraspag::Request::SimplifiedDebitCard

      def pay
        send_request if valid_?
      end

      private
      def send_request
        @ws_client ||= KBraspag::WebService::SimplifiedDebitCard.new
        @ws_client.send_request(self)
      end
    end
  end
end
