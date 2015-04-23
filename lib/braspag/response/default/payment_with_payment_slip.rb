module KBraspag
  module Response
    module Default
      require 'lib/braspag/response/default/payment'

      class PaymentWithPaymentSlip < KBraspag::Response::Default::Payment

        def initialize(hash)
          super(hash)
          @instructions = hash['Instructions']
          @expiration_date = hash['ExpirationDate']
          @url = hash['Url']
          @number = hash['Number']
          @bar_code_number = hash['BarCodeNumber']
          @digitable_line = hash['DigitableLine']
          @assignor = hash['Assignor']
          @address = hash['Address']
          @identification = hash['Identification']
          @payment_id = hash['PaymentId']
          @reason_code = hash['ReasonCode']
          @reason_message = hash['ReasonMessage']
          @links = KBrapag::Response::Default::Link.build_array(hash['Links'])
        end

      end
    end
  end
end
