module Braspag
  module Model
    module Default
      require 'bigdecimal'
      require 'bigdecimal/util'
      require 'lib/helpers/helpers'

      class Payment
        include Braspag::Helpers

        attr_reader :type, :amount, :provider, :installments
        @@TYPES = {:credit_card => "CreditCard", :debit_card => "DebitCard", :eletronic_transfer => "EletronicTransfer", :payment_slip => "Boleto"}

        def initialize
          @type = nil
          @amount = nil
          @provider = nil
          @installments = nil
        end

        def type=(type)
          raise TypeError, msg_invalid_class(type, Symbol) if invalid_class_type?(type, Symbol)
          raise ArgumentError, msg_invalid_parameter(type, @@TYPES) if type_not_exist?(type)
          @type = @@TYPES[type]
        end

        def amount=(amount)
          amount = standardize_amount(amount)
          raise ArgumentError, msg_less_or_equal_zero(amount) if less_or_equal_zero?(amount)
          @amount = amount
        end

        def provider=(provider)
          raise ArgumentError, msg_invalid_class(provider, String) if invalid_class_type?(provider, String)
          @provider = provider
        end

        def installments=(installments)
          raise TypeError, msg_invalid_class(installments, Integer) if invalid_class_type?(installments, Integer)
          raise ArgumentError, msg_less_or_equal_zero(installments) if less_or_equal_zero?(installments)
          @installments = installments
        end

        def to_braspag_hash
          {
            "Type" => @type,
            "Amount" => @amount,
            "Provider" => @provider,
            "Installments" => @installments
          }
        end

        # def valid?
        #   instance_variables.each do | at |
        #     at.gsub!('@','')
        #     raise ArgumentError, msg_can_not_be_empty(at) if send(at).nil?
        #   end
        #   true
        # end

        private
        def type_not_exist?(type)
          !@@TYPES.key? type
        end

        def less_or_equal_zero?(value)
          value <= 0
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
          value << '0' unless value !~ /^.*\d+[\,|\.]\d{1}$/
          value
        end
      end
    end
  end
end
