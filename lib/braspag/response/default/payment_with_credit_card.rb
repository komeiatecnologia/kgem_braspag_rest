module KBraspag
  module Response

    class PaymentWithCreditCard < KBraspag::Response::Default::Payment
      attr_accessor :acquirer_transaction_id, :authenticate, :capture,
                    :credit_card, :installments, :interest, :links, :payment_id,
                    :reason_code, :reason_message, :service_tax_amount,
                    :proof_of_sale, :authorization_code, :provider_return_code,
                    :provider_return_message

      def initialize(hash)
        super(hash)
        @acquirer_transaction_id = hash['AcquirerTransactionId']
        @authenticate = hash['Authenticate']
        @capture = hash['Capture']
        @credit_card = KBraspag::Response::Default::CreditCard.new(hash['CreditCard'])
        @installments = hash['Installments']
        @interest = hash['Interest']
        @links = KBraspag::Response::Default::Link.build_array(hash['Links'])
        @payment_id = hash['PaymentId']
        @reason_code = hash['ReasonCode']
        @reason_message = hash['ReasonMessage']
        @service_tax_amount = hash['ServiceTaxAmount']
        @proof_of_sale = hash['ProofOfSale']
        @authorization_code = hash['AuthorizationCode']
        @provider_return_code = hash['ProviderReturnCode']
        @provider_return_message = hash['ProviderReturnMessage']
      end
    end
  end
end
