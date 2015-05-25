module KBraspag
  module Request
    #require 'helpers/helpers'
    class Query
      include KBraspag::Helpers

      attr_reader :payment_id

      def initializer
        @payment_id = nil
        @merchant_order_id = nil
      end

      def payment_id=(payment_id)
        if valid_payment_id?(payment_id)
          @payment_id = payment_id
          @merchant_order_id = nil
        end
      end

      def merchant_order_id=(merchant_order_id)
        if valid_merchant_order_id?(merchant_order_id)
          @merchant_order_id = merchant_order_id
          @payment_id = nil
        end
      end

      def valid_?
        if @merchant_order_id.nil? && @payment_id.nil?
          raise ArgumentError, "No informed parameter", "#{self.class}"
        elsif @merchant_order_id.nil?
          present_?(@payment_id, :payment_id)
        elsif @payment_id.nil?
          present_?(@merchant_order_id, :merchant_order_id)
        end
      end

      private
      def valid_payment_id?(payment_id)
        valid_class_type_?("payment_id", payment_id, String)
        valid_payment_id_format?(payment_id)
      end

      def valid_merchant_order_id?(merchant_order_id)
        valid_class_type_?("merchant_order_id", merchant_order_id, String)
      end

    end
  end
end
