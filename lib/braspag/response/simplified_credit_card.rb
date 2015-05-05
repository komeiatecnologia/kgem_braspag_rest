module KBraspag
  module Response
    require 'lib/braspag/response/default/customer'
    require 'lib/braspag/response/default/response'
    require 'lib/braspag/response/default/payment_with_credit_card'

    class SimplifiedCreditCard < KBraspag::Response::Default::Response
      attr_reader :payment, :customer

      def initialize(hash)
        super(hash)
        @customer = KBraspag::Response::Default::Customer.new(hash['Customer'])
        @payment = KBraspag::Response::PaymentWithCreditCard.new(hash['Payment'])
        @payment.create_get_method("proof_of_sale", hash['ProofOfSale'])
        @payment.create_get_method("authorization_code", hash['AuthorizationCode'])
        @payment.create_get_method("provider_return_code", hash['ProviderReturnCode'])
        @payment.create_get_method("provider_return_message", hash['ProviderReturnMessage'])
      end

    end
  end
end
