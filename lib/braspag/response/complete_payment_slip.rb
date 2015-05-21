module KBraspag
  module Response
    # require 'lib/braspag/response/default/response'
    # require 'lib/braspag/response/default/customer'
    # require 'lib/braspag/response/default/payment_with_payment_slip'

    class CompletePaymentSlip < KBraspag::Response::Default::Response
      attr_reader :payment, :customer

      def initialize(hash)
        super(hash)
        @payment = Default::PaymentWithPaymentSlip.new(hash['Payment'])
        @customer = Default::Customer.new(hash['Customer'])
      end

      def paid?
        @paid ||= payment_slip_paid?(@payment.status)
      end
    end
  end
end

