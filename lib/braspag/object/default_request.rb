module Braspag
  module Object
    class DefaultRequest
      attr_accessor :MerchantOrderId, :Customer, :Payment

      def initialize
        @MerchantOrderId = nil
        @Customer = nil
        @Payment = nil
      end
    end
  end
end
