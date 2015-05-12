module KBraspag
  module Request
    # require 'lib/helpers/helpers'
    class Cancel
      include KBraspag::Helpers

      attr_reader :payment_id, :amount

      def initialize
        @amount = nil
        @payment_id = nil
      end

      def amount=(amount)
        amount = standardize_amount(amount)
        @amount = amount if valid_amount?(amount)
      end

      def payment_id=(payment_id)
        @payment_id = payment_id if valid_payment_id?(payment_id)
      end

      def valid_?
        present_?(payment_id, "payment_id")
      end

      private
      def valid_amount?(amount)
        greater_than_zero_?(amount)
      end

      def valid_payment_id?(payment_id)
        valid_class_type_?("payment_id", payment_id, String)
        valid_payment_id_format?(payment_id)
      end

      def valid_payment_id_format?(payment_id)
        raise(ArgumentError,
              "Invalid payment_id, expected xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
              self.class.to_s) if payment_id !~ /^\w{8}-\w{4}-\w{4}-\w{4}-\w{12}$/
        true
      end
    end
  end
end
