module KBraspag
  module Request
    module Default
      # require 'lib/braspag/request/default/payment'
      # require 'lib/braspag/request/default/credit_card'

      class PaymentWithCreditCard < KBraspag::Request::Default::Payment
        attr_accessor :credit_card
        attr_accessor :capture, :interest

        def initialize
          @credit_card = KBraspag::Request::Default::CreditCard.new
          @capture = true
          @interest = KBraspag.interest
          send(:type=, :credit_card)
        end

        def provider=(provider)
          @provider = provider if valid_provider?(provider)
        end

        def interest=(interest)
          @interest = interest  if valid_interest?(interest)
        end

        def to_braspag_hash
          h = super
          h['CreditCard'] = @credit_card.to_braspag_hash
          h['Capture'] = @capture
          h['Interest'] = KBraspag.responsible_for_installment[@interest]
          h['Provider'] =  KBraspag.credit_card_providers[@provider]
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

        def valid_interest?(interest)
          valid_class_type_?(:interest, interest, Symbol)
          parameter_exists_?(interest, KBraspag.responsible_for_installment)
        end
      end
    end
  end
end
