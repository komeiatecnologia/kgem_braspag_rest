module KBraspag
  module Request




    class CompletePaymentSlip < KBraspag::Request::Default::Request
      def initialize
        send(:customer=, KBraspag::Request::Default::Customer.new)
        send(:payment=, KBraspag::Request::Default::PaymentWithCompletePaymentSlip.new)
      end
    end
  end
end
