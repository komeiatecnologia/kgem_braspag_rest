module Braspag
  module Model
    require 'lib/braspag/Model/default_request'
    require 'lib/braspag/Model/default_customer'
    require 'lib/braspag/Model/payment_with_credit_card'

    class SimplifiedCreditCardSale < Braspag::Model::DefaultRequest

      def initialize
        @payment = Braspag::Model::PaymentWithCreditCard.new
        @customer = Braspag::Model::DefaultCustomer.new
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
