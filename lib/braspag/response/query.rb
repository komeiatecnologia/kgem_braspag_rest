module KBraspag
  module Response
    #require 'braspag/pagador/pagador'

    class Query
      Builders = {
        :error => KBraspag::Response::Default::Response,
        "CreditCard" => KBraspag::Response::SimplifiedCreditCard,
        "Boleto" => KBraspag::Response::CompletePaymentSlip
      }

      def self.build_response(response)
        if response.kind_of? Net::HTTPSuccess
          type = response['Payment']['Type']
          Builders[type].build_response(response)
        else
          Builders[:error].build_response(response)
        end
      end

    end
  end
end
