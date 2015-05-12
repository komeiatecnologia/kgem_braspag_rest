module KBraspag
  module Request
    module Default
      # require 'lib/braspag/request/default/payment'

      class PaymentWithPaymentSlip < KBraspag::Request::Default::Payment
        # # Remove os métodos herdados
        # undef_method :installments
        # undef_method :installments=

        def initialize
          super
          send(:type=, :payment_slip)
          remove_instance_variable :@installments #remove a variável de instancia herdada
        end

        def to_braspag_hash
          h = super
          h.delete('Installments')
          h
        end

        def provider=(provider)
          @provider = KBraspag.payment_slip_providers[provider] if valid_provider?(provider)
        end

        private
        def valid_provider?(provider)
          valid_class_type_?(:provider, provider, Symbol)
          parameter_exists_?(provider, KBraspag.payment_slip_providers)
        end
      end
    end
  end
end
