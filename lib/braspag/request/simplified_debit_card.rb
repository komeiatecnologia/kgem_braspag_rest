module KBraspag
  module Request

    class SimplifiedDebitCard < KBraspag::Request::Default::Request

      def initialize
        send(:payment=, KBraspag::Request::Default::PaymentWithDebitCard.new)
        send(:customer=, KBraspag::Request::Default::Customer.new)
      end

    end
  end
end
