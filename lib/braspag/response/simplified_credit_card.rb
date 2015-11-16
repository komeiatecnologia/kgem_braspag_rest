module KBraspag
  module Response




    class SimplifiedCreditCard < KBraspag::Response::Default::Response
      attr_reader :payment, :customer

      def initialize(hash)
        super(hash)
        @customer = KBraspag::Response::Default::Customer.new(hash['Customer'])
        @payment = KBraspag::Response::PaymentWithCreditCard.new(hash['Payment'])
        @payment.create_get_method("proof_of_sale", hash['Payment']['ProofOfSale'])
        @payment.create_get_method("authorization_code", hash['Payment']['AuthorizationCode'])
        @payment.create_get_method("provider_return_code", hash['Payment']['ProviderReturnCode'])
        @payment.create_get_method("provider_return_message", hash['Payment']['ProviderReturnMessage'])
      end

      def paid?
        @paid ||= credit_card_paid?(@payment.status)
      end
    end
  end
end
