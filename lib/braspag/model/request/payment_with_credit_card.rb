module Braspag
  module Model
    module Request
      require 'lib/braspag/model/default/payment'
      require 'lib/braspag/model/default/credit_card'

      class PaymentWithCreditCard < Braspag::Model::Default::Payment
        attr_accessor :credit_card

        def initialize
          @credit_card = Braspag::Model::Default::CreditCard.new
          send(:type=, :credit_card)
        end

        def to_braspag_hash
          h = super
          h['CreditCard'] = @credit_card.to_braspag_hash
          h
        end
      end
    end
  end
end
