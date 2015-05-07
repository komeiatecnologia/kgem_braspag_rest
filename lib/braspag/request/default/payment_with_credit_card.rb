module KBraspag
  module Request
    module Default
      # require 'lib/braspag/request/default/payment'
      # require 'lib/braspag/request/default/credit_card'

      class PaymentWithCreditCard < KBraspag::Request::Default::Payment
        attr_accessor :credit_card

        def initialize
          @credit_card = KBraspag::Request::Default::CreditCard.new
          send(:type=, :credit_card)
        end

        def to_braspag_hash
          h = super
          h['CreditCard'] = @credit_card.to_braspag_hash
          h
        end

        def valid?
          super
          @credit_card.valid?
        end
      end
    end
  end
end
