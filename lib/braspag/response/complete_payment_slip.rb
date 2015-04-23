module KBraspag
  module Response
    require 'lib/braspag/response/default/response'
    require 'lib/braspag/response/default/customer'
    require 'lib/braspag/response/default/payment_with_payment_slip'

    class CompletePaymentSlip < KBraspag::Response::Default::Response

      def initialize(hash)
        @payment = KBraspag::Response::Default::PaymentWithPaymentSlip.new(hash['Payment'])
        @customer =KBraspag::Response::Default::Customer.new(hash['Customer'])
        send(:merchant_order_id, hash['MerchantOrderID'])
      end

    end
  end
end
