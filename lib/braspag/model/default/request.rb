module Braspag
  module Model
    require 'lib/helpers/helpers'

    class DefaultRequest
      include Braspag::Helpers

      attr_reader :merchant_order_id, :customer, :payment

      @@ONLY_NUMBERS = /^\d+$/.freeze

      def initialize
        @merchant_order_id = nil
        @customer = nil
        @payment = nil
      end

      def merchant_order_id=(merchant_order_id)
        raise TypeError, msg_invalid_class(merchant_order_id, String) if invalid_class_type?(merchant_order_id, String)
        raise ArgumentError, msg_can_not_be_empty("merchant_order_id") if empty?(merchant_order_id)
        raise ArgumentError, "Invalid merchant_order_id: #{merchant_order_id}, expected only numbers" if invalid_merchant_order_id?(merchant_order_id)
        @merchant_order_id = merchant_order_id
      end

      def customer=(customer)
        raise TypeError, msg_invalid_class(customer,default_customer_class ) if invalid_class_type?(customer, default_customer_class)
        @customer = customer
      end

      def payment=(payment)
        raise TypeError, msg_invalid_class(payment, payment_class) if invalid_class_type?(payment, payment_class)
        @payment = payment
      end

      def to_braspag_hash
        {
          "MerchantOrderId" => @merchant_order_id,
          "Customer" => @customer.to_braspag_hash,
          "Payment" => @payment.to_braspag_hash
        }
      end

      private
      def invalid_merchant_order_id?(merchant_order_id)
        merchant_order_id !~ @@ONLY_NUMBERS
      end

      def default_customer_class
        Braspag::Model::DefaultCustomer
      end

      def payment_class
        Braspag::Model::Payment
      end
    end
  end
end
