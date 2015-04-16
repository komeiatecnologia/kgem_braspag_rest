module KBraspag
  module Payment
    class PaymentSlip
      def simplified_sale(order)
      end

      def complete_sale(order)

      end

      private
      def complete_parameters_sale
        {
          "MerchantOrderId" => "",
          "Customer" => {
            "Name" => ""
          },
          "Payment" => {
            "Type" => "Boleto",
            "Amount" => 15700,
            "Provider" => "Simulado",
            "Address" => "Rua Teste",
            "BoletoNumber" => "123",
            "Assignor" => "Empresa Teste",
            "Demonstrative" => "Desmonstrative Teste",
            "ExpirationDate" => "xx/xx/xxxx",
            "Identification" => "11884926754",
            "Instructions" => "Aceitar somente até a data de vencimento, após essa data juros de 1% dia."
          }
        }
      end

      def simplified_parameters_sale
        {
          "MerchantOrderId" => "2014111706",
          "Customer" =>  {
            "Name" => "Comprador Teste"
          },
          "Payment" => {
            "Type" => "Boleto",
            "Amount" => 15700,
            "Provider" => "Simulado"
          }
        }

        def commons_parameters

        end
      end
    end

    class CompletePaymentSlip
      def initalize

      end

      def sale
      end
    end

    class SimplifiedPaymentSlip
      def sale
      end
    end
  end
end
