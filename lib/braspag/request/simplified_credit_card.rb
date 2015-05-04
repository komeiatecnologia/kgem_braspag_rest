module KBraspag
  module Request
    require 'lib/braspag/request/default/request'
    require 'lib/braspag/request/default/customer'
    require 'lib/braspag/request/default/payment_with_credit_card'

    class SimplifiedCreditCard < KBraspag::Request::Default::Request

      def initialize
        send(:payment=, KBraspag::Request::Default::PaymentWithCreditCard.new)
        send(:customer=, KBraspag::Request::Default::Customer.new)
      end

    end
  end
end
