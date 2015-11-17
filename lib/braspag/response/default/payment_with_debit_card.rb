module KBraspag
  module Response

    class PaymentWithDebitCard < KBraspag::Response::Default::Payment
      attr_accessor :acquirer_transaction_id, :authentication_url, :debit_card,
                    :links, :payment_id, :reason_code, :reason_message, :return_url

      def initialize(hash)
        super(hash)
        @acquirer_transaction_id = hash['AcquirerTransactionId']
        @authentication_url = hash['AuthenticationUrl']
        @debit_card = KBraspag::Response::Default::DebitCard.new(hash['DebitCard'])
        @links = KBraspag::Response::Default::Link.build_array(hash['Links'])
        @payment_id = hash['PaymentId']
        @reason_code = hash['ReasonCode']
        @reason_message = hash['ReasonMessage']
        @return_url = hash['ReturnUrl']
      end
    end
  end
end
