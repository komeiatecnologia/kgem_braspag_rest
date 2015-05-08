module KBraspag
  module Request
    module Default
      class Payment
        include KBraspag::Helpers

        attr_reader :type, :amount, :provider, :installments

        def initialize
          @type = nil
          @amount = nil
          @provider = nil
          @installments = nil
        end

        def type=(type)
          type = type_to_symbol_valid(type) if type.kind_of? String
          @type = KBraspag.payment_types[type] if valid_type?(type)
        end

        def amount=(amount)
          amount = standardize_amount(amount)
          @amount = amount if valid_amount?(amount)
        end

        def provider=(provider)
          @provider = KBraspag.payment_slip_providers[provider] if valid_provider?(provider)
        end

        def installments=(installments)
          @installments = installments if valid_installments?(installments)
        end

        def to_braspag_hash
          {
            "Type" => @type,
            "Amount" => @amount,
            "Provider" => @provider,
            "Installments" => @installments
          }
        end

        private
        def valid_type?(type)
          valid_class_type?(type, Symbol) && parameter_exists?(type, KBraspag.payment_types)
        end

        def valid_amount?(amount)
          greater_than_zero?(amount)
        end

        def valid_provider?(provider)
          valid_class_type?(provider, Symbol)
          parameter_exists?(provider, KBraspag.payment_slip_providers)
        end

        def valid_installments?(installments)
          valid_class_type?(installments, Integer) && greater_than_zero?(installments)
        end

        def type_to_symbol_valid(type)
          type == "Boleto" ? :payment_slip : type_to_symbol(type)
        end

        def type_to_symbol(type)
          camelcase_to_snakecase(type).to_sym
        end
      end
    end
  end
end
