module KBraspag
  module Request
    module Default
      require 'lib/braspag/request/default/payment'

      class PaymentWithPaymentSlip < KBraspag::Request::Default::Payment
        # Remove os métodos herdados
        undef_method :installments
        undef_method :installments=

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
      end
    end
  end
end
