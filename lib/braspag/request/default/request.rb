module KBraspag
  module Request
    module Default
      class Request
        include KBraspag::Helpers

        attr_reader :merchant_order_id, :customer, :payment

        @@ONLY_NUMBERS = /^\d+$/.freeze

        def initialize
          @merchant_order_id = nil
          @customer = nil
          @payment = nil
        end

        def merchant_order_id=(merchant_order_id)
          @merchant_order_id = merchant_order_id if valid_merchant_order_id?(merchant_order_id)
        end

        def customer=(customer)
          @customer = customer if valid_customer?(customer)
        end

        def payment=(payment)
          @payment = payment if valid_payment?(payment)
        end

        def to_braspag_hash
          {
            "MerchantOrderId" => @merchant_order_id,
            "Customer" => @customer.to_braspag_hash,
            "Payment" => @payment.to_braspag_hash
          }
        end

        def valid_?
          present_?(@merchant_order_id, "merchant_order_id")
          present_?(@customer, "customer")
          @customer.valid_?
          present_?(@payment, "payment")
          @payment.valid_?
        end

        private
        def valid_payment?(payment)
          valid_class_type_?(:payment, payment, payment_class)
        end

        def valid_customer?(customer)
          valid_class_type_?(:customer, customer, customer_class)
        end

        def valid_merchant_order_id?(merchant_order_id)
          valid_class_type_?(:merchant_order_id, merchant_order_id, String) && present_?(merchant_order_id, "merchant_order_id") && valid_merchant_order_id_format?(merchant_order_id)
        end

        def valid_merchant_order_id_format?(merchant_order_id)
          raise ArgumentError, "Invalid merchant_order_id: #{merchant_order_id}, expected only numbers" if merchant_order_id !~ @@ONLY_NUMBERS
          true
        end

        def customer_class
          KBraspag::Request::Default::Customer
        end

        def payment_class
          KBraspag::Request::Default::Payment
        end
      end
    end
  end
end
