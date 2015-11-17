module KBraspag
  module Request
    module Default
      class PaymentWithPaymentSlip < KBraspag::Request::Default::Payment

        def initialize
          super
          send(:type=, :payment_slip)
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
