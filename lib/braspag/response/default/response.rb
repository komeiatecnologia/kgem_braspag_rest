module KBraspag
  module Response
    module Default
      class Response
        attr_reader :merchant_order_id

        def initialize(hash)
          @merchant_order_id = hash['MerchantOrderId']
        end
      end
    end
  end
end
