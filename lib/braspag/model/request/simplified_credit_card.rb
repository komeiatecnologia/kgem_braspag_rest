module Braspag
  module Model
    module Request
      require 'lib/braspag/model/default/request'
      require 'lib/braspag/model/default/customer'
      require 'lib/braspag/model/request/payment_with_credit_card'

      class SimplifiedCreditCard < Braspag::Model::Default::Request

        def initialize
          @payment = Braspag::Model::Request::PaymentWithCreditCard.new
          @customer = Braspag::Model::Default::Customer.new
        end

        def to_braspag_hash
          h = super
          h["Payment"] = @payment.to_braspag_hash
          h["Customer"] = @customer.to_braspag_hash
          h
        end
      end
    end
  end
end
