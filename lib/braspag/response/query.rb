module KBraspag
  module Response
    #require 'braspag/pagador/pagador'

    class Query
      BOLETO = /"Type":"Boleto"/
      CREDIT_CARD = /"Type":"CreditCard"/

      BUILDERS = {
        :error => KBraspag::Response::Default::Response,
        :credit_card => KBraspag::Response::SimplifiedCreditCard,
        :payment_slip => KBraspag::Response::CompletePaymentSlip
      }

      def self.build_response(response)
        if response.kind_of? Net::HTTPSuccess
          formatter(response.body).build_response(response)
        else
          BUILDERS[:error].build_response(response)
        end
      end

      private
      def self.formatter(body)
        return BUILDERS[:payment_slip] if BOLETO =~ body
        # incluir as demais opções aqui, para não haver falso verdadeiro
        # no caso do cartão de crédito
        return BUILDERS[:credit_card] if CREDIT_CARD =~ body
      end
    end
  end
end
