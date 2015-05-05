module KBraspag
  module Request
    require 'lib/helpers/helpers'
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

      def valid?
        valid_payment_id?(@payment_id)
      end

      private
      def valid_amount?(amount)
        greater_than_zero?(amount)
      end

      def valid_payment_id?(payment_id)
        if payment_id !~ /^.{8}-.{4}-.{4}-.{4}-.{12}$/
          raise ArgumentError, "Invalid payment_id, expected xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", self.class.to_s
        end
        true
      end
    end
  end
end
