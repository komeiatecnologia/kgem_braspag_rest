module KBraspag
  module Response

    class PaymentWithCreditCard < KBraspag::Response::Default::Payment
      attr_accessor :acquirer_transaction_id, :authenticate, :capture
      attr_accessor :credit_card, :installments, :interest, :links, :payment_id
      attr_accessor :reason_code, :reason_message, :service_tax_amount

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
      end
    end
  end
end
