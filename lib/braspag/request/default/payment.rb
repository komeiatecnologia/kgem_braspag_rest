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
          valid_class_type_?(:type, type, Symbol) && parameter_exists_?(type, KBraspag.payment_types)
        end

        def valid_amount?(amount)
          greater_than_zero_?(amount)
        end

        def valid_installments?(installments)
          valid_class_type_?(:installments, installments, Integer) && greater_than_zero_?(installments)
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
