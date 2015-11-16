module KBraspag
  module Request




    class SimplifiedCreditCard < KBraspag::Request::Default::Request

      def initialize
        send(:payment=, KBraspag::Request::Default::PaymentWithCreditCard.new)
        send(:customer=, KBraspag::Request::Default::Customer.new)
      end

    end
  end
end
