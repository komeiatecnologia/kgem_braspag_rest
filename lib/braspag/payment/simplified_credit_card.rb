module Braspag
  module Payment
    require 'lib/braspag/webservice/rest_client'
    require 'lib/braspag/Model/simplified_credit_card_sale'
    class SimplifiedCreditCard < Braspag::Model::SimplifiedCreditCardSale
      def initialize
        @sucess = false
        @errors = nil
      end
    end
  end
end
