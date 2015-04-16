module KBraspag
  module Response
    require 'lib/braspag/response/default/payment'
    require 'lib/braspag/response/default/credit_card'

    class PaymentWithCreditCard < KBraspag::Response::Default::Payment
      attr_accessor :acquirer_transaction_id, :authenticate, :capture, :credit_card, :installments, :interest, :links, :payment_id, :reason_code, :reason_message, :service_tax_amount

      def initialize(hash)
        super(hash)
        @acquirer_transaction_id = hash['AcquirerTransactionId']
        @authenticate = hash['Authenticate']
        @capture = hash['Capture']
        @credit_card = KBraspag::Response::Default::CreditCard.new(hash['CreditCard'])
        @installments = hash['Installments']
        @interest = hash['Interest']
        @links = hash['Links']
        @payment_id = hash['PaymentId']
        @reason_code = hash['ReasonCode']
        @reason_message = hash['ReasonMessage']
        @service_tax_amount = hash['ServiceTaxAmount']
      end
    end
  end
end
