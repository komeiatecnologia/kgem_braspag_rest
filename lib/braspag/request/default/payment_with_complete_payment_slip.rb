module KBraspag
  module Request
    module Default
      # require 'lib/braspag/request/default/payment_with_payment_slip'
      # require 'lib/helpers/helpers'

      class PaymentWithCompletePaymentSlip < KBraspag::Request::Default::PaymentWithPaymentSlip
        include KBraspag::Helpers

        attr_reader :address, :assignor, :demonstrative, :expiration_date, :identification, :instructions, :payment_slip_number

        def initialize
          super
          @address = nil
          @assignor = nil
          @demonstrative = nil
          @expiration_date = nil
          @identification = nil #CPF ou RG sem pontos e traços
          @instructions = nil
          @payment_slip_number = nil # Nosso número
        end

        def address=(address)
          @address = address if valid_address?(address)
        end

        def assignor=(assignor)
          @assignor = assignor if valid_assignor?(assignor)
        end

        def demonstrative=(demonstrative)
          @demonstrative = demonstrative if valid_demonstrative?(demonstrative)
        end

        def expiration_date=(expiration_date)
          @expiration_date = expiration_date if valid_expiration_date?(expiration_date)
        end

        def identification=(identification)
          @identification = identification if valid_identification?(identification)
        end

        def instructions=(instructions)
          @instructions = instructions if valid_instructions?(instructions)
        end

        def payment_slip_number=(payment_slip_number)
          @payment_slip_number = payment_slip_number if valid_payment_slip_number?(payment_slip_number)
        end

        def to_braspag_hash
          h = super
          h['Address'] = @address
          h['BoletoNumber'] = @payment_slip_number
          h['Assignor'] = @assignor
          h['Demonstrative'] = @demonstrative
          h['ExpirationDate'] = @expiration_date
          h['Identification'] = @identification
          h['Instructions'] = @instructions
          h
        end

        private
        def valid_address?(address)
          valid_class_type?(address, String) && present?(address, "address")
        end

        def valid_assignor?(assignor)
          valid_class_type?(assignor, String) && present?(assignor, "assignor")
        end

        def valid_demonstrative?(demonstrative)
          valid_class_type?(demonstrative, String) && present?(demonstrative, "demonstrative")
        end

        def valid_expiration_date?(expiration_date)
          valid_class_type?(expiration_date, String) && present?(expiration_date, "expiration_date") && greater_than_current_date?(expiration_date)
        end

        def valid_identification?(identification)
          valid_class_type?(identification, String) && present?(identification, "identification") && valid_identification_format?(identification)
        end

        def valid_identification_format?(identification)
          @@VALID_IDENTIFICATION ||= /^\d{1,10}$/
          raise ArgumentError, "Invalid identification, expected string with max 10 numeric characters(CPF/CPNJ)" if identification !~ @@VALID_IDENTIFICATION
          true
        end

        def valid_instructions?(instructions)
          valid_class_type?(instructions, String) && present?(instructions, "instructions")
        end

        def valid_payment_slip_number?(payment_slip_number)
          valid_class_type?(payment_slip_number, String) && present?(payment_slip_number, "payment_slip_number") && valid_payment_slip_format?(payment_slip_number)
        end

        def valid_payment_slip_format?(payment_slip_number)
          @@VALID_PAYMENT_SLIP_NUMBER ||= /^\d{1,50}$/
          raise ArgumentError, "Invalid payment slip number, expected max string with 1..50 numeric characters", "#{self.class}" if payment_slip_number !~ @@VALID_PAYMENT_SLIP_NUMBER
          true
        end
      end
    end
  end
end
