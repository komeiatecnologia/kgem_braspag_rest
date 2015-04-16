module KBraspag
  module Request
    module Default
      require 'bigdecimal'
      require 'bigdecimal/util'
      require 'lib/helpers/helpers'

      class Payment
        include KBraspag::Helpers

        attr_reader :type, :amount, :provider, :installments
        @@TYPES = {:credit_card => "CreditCard", :debit_card => "DebitCard", :eletronic_transfer => "EletronicTransfer", :payment_slip => "Boleto"}.freeze
        @@LAST_DECIMAL_PLACE = /^.*\d+[\,|\.]\d{1}$/.freeze

        def initialize
          @type = nil
          @amount = nil
          @provider = nil
          @installments = nil
        end

        def type=(type)
          type = type_to_symbol_valid(type) if type.kind_of? String
          @type = @@TYPES[type] if valid_type?(type)
        end

        def amount=(amount)
          amount = standardize_amount(amount)
          @amount = amount if valid_amount?(amount)
        end

        def provider=(provider)
          @provider = provider if valid_provider?(provider)
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
          valid_class_type?(type, Symbol) && parameter_exists?(type, @@TYPES)
        end

        def valid_amount?(amount)
          greater_than_zero?(amount)
        end

        def valid_provider?(provider)
          valid_class_type?(provider, String)
        end

        def valid_installments?(installments)
          valid_class_type?(installments, Integer) && greater_than_zero?(installments)
        end

        def standardize_amount(value)
          value = string_to_integer(value) if value.kind_of? String
          value = bigdecimal_to_integer(value) if value.kind_of? BigDecimal
          value = float_to_integer(value) if value.kind_of? Float
          value
        end

        def string_to_integer(value)
          value = insert_last_decimal_place(value)
          value.gsub(/\D/, '').to_i
        end

        def bigdecimal_to_integer(value)
          value = value.to_digits
          string_to_integer(value)
        end

        def float_to_integer(value)
          value = value.to_s
          string_to_integer(value)
        end

        def insert_last_decimal_place(value)
          value << '0' unless value !~ @@LAST_DECIMAL_PLACE
          value
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
