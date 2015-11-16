module KBraspag
  module Payment



    class SimplifiedCreditCard < KBraspag::Request::SimplifiedCreditCard

      def pay
        send_request if valid_?
      end

      private
      def send_request
        @ws_client ||= KBraspag::WebService::SimplifiedCreditCard.new
        @ws_client.send_request(self)
      end
    end
  end
end
