module KBraspag
  module Response
    class SimplifiedCreditCard < KBraspag::Response::Default::Response
      attr_reader :payment, :customer

      def initialize(hash)
        super(hash)
        @customer = KBraspag::Response::Default::Customer.new(hash['Customer'])
        @payment = KBraspag::Response::PaymentWithCreditCard.new(hash['Payment'])
      end

      def paid?
        @paid ||= credit_card_paid?(@payment.status)
      end
    end
  end
end
