module KBraspag
  module Response
    require 'braspag/response/default/customer'
    require 'braspag/response/default/response'
    require 'braspag/response/payment_with_credit_card'
    require 'braspag/pagador/pagador'

    class SimplifiedCreditCard < KBraspag::Response::Default::Response
      include KBraspag::Pagador

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

      def success?
        operation_success?(@payment.status)
      end

      def message
        REASON_MESSAGE[@payment.reason_code]
      end
    end
  end
end
