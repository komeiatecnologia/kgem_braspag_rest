module KBraspag
  module Payment
    class Cancel < KBraspag::Request::Cancel

      def cancel(payment_id, amount = nil)
        send_request if valid?
      end

      private
      def send_request
        @ws_client ||= KBraspag::WebService::Cancel.new
        @ws_client.send_request(@payment_id, @amount)
      end
    end
  end
end
