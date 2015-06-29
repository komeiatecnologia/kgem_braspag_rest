module KBraspag
  module Request
    module Default
      # require 'lib/braspag/request/default/payment'
      # require 'lib/braspag/request/default/credit_card'

      class PaymentWithCreditCard < KBraspag::Request::Default::Payment
        attr_accessor :credit_card
        attr_accessor :capture

        def initialize
          @credit_card = KBraspag::Request::Default::CreditCard.new
          @capture = true
          send(:type=, :credit_card)
        end

        def provider=(provider)
          @provider = KBraspag.credit_card_providers[provider] if valid_provider?(provider)
        end

        def to_braspag_hash
          h = super
          h['CreditCard'] = @credit_card.to_braspag_hash
          h['Capture'] = @capture
          h
        end

        def valid_?
          super
          @credit_card.valid_?
        end

        private
        def valid_provider?(provider)
          valid_class_type_?(:provider, provider, Symbol)
          parameter_exists_?(provider, KBraspag.credit_card_providers)
        end
      end
    end
  end
end
