module KBraspag
  module Response
    class SimplifiedDebitCard < KBraspag::Response::Default::Response
      attr_reader :payment, :customer

      def initialize(hash)
        super(hash)
        @customer = KBraspag::Response::Default::Customer.new(hash['Customer'])
        @payment = KBraspag::Response::PaymentWithDebitCard.new(hash['Payment'])
      end

      def paid?
        @paid ||= credit_card_paid?(@payment.status)
      end

      def authentication_url
        @authentication_url ||= @payment.authentication_url
      end

    end
  end
end
