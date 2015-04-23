module KBraspag
  module Request
    require 'lib/braspag/request/default/request'
    require 'lib/braspag/request/default/customer'
    require 'lib/braspag/request/default/payment_with_complete_payment_slip'

    class CompletePaymentSlip < KBraspag::Request::Default::Request
      def initialize
        send(:customer=, KBraspag::Request::Default::Customer.new)
        send(:payment=, KBraspag::Request::Default::PaymentWithCompletePaymentSlip.new)
      end
    end
  end
end
