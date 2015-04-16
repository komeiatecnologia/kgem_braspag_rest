module KBraspag
  module Request
    require 'lib/braspag/request/default/request'
    require 'lib/braspag/request/default/customer'
    require 'lib/braspag/request/payment_with_credit_card'

    class SimplifiedCreditCard < KBraspag::Request::Default::Request

      def initialize
        @payment = KBraspag::Request::PaymentWithCreditCard.new
        @customer = KBraspag::Request::Default::Customer.new
      end

      def to_braspag_hash
        h = super
        h["Payment"] = @payment.to_braspag_hash
        h["Customer"] = @customer.to_braspag_hash
        h
      end
    end
  end
end
