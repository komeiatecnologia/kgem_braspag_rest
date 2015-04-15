module Braspag
  module Model
    module Response
      require 'lib/braspag/model/response/customer'
      require 'lib/braspag/model/default/response'
      require 'lib/braspag/model/response/payment_with_credit_card'

      class SimplifiedCreditCard < Braspag::Model::Default::Response

        def initialize(hash)
          super(hash)
          @customer = Braspag::Model::Response::Customer.new(hash)
          @payment = Braspag::Model::Response::PaymentWithCreditCard.new(hash)
          @payment.create_get_method("proof_of_sale", hash['ProofOfSale'])
          @payment.create_get_method("authorization_code", hash['AuthorizationCode'])
          @payment.create_get_method("provider_return_code", hash['ProviderReturnCode'])
          @payment.create_get_method("provider_return_message", hash['ProviderReturnMessage'])
        end
      end
    end
  end
end
