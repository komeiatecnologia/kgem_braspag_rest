KBraspag.configuration do |config|
  ## PAYMENT METHODS AVAILABLE
  config.payment_types, {
                          :credit_card => "CreditCard", :debit_card => "DebitCard",
                          :eletronic_transfer => "EletronicTransfer", :payment_slip => "Boleto"
                         }

  ## CREDIT CARD BRANDS AVAILABLE
  config.brands, {
                    :visa => 'Visa', :mastercard => 'Mastercard',
                    :amex => 'Amex', :elo => 'Elo', :auria => 'Auria',
                    :jcb => 'JCB', :diners => 'Diners', :discover => 'Discover'
                  }

  ## AVAILABLE PROVIDERS LIST
  config.credit_card_providers, {
                                   :simulado => "Simulado",
                                   :cielo => "Cielo",
                                   :rede => "Redecard"
                                 }
  config.debit_providers, {:cielo => "Cielo"}
  config.payment_slip_providers, {
                                    :bradesco => "Bradesco",
                                    :banco_do_brasil => "BancoDoBrasil",
                                    :citibank => "CitiBank",
                                    :itau => "Itau",
                                    :brb => "Brb",
                                    :caixa => "Caixa",
                                    :simulado => "Simulado"
                                  }
  config.eletronic_transfer_providers, {
                                          :bradesco => "Bradesco",
                                          :simulado => "Simulado"
                                        }

  ##REQUEST SETTINGS
  config.timeout, 5
  config.merchant_id, "e895fcba-14df-49f6-a019-e576c136f520"
  config.merchant_key, "FLKAVCQRLZKEZFFSDOYDBXPMWSUYWFSCMGDNKYYJ"
  config.connection_attempts, 3

  ##URLs
  config.payment_url, "https://apisandbox.braspag.com.br"
  config.query_url, "https://apiquerysandbox.braspag.com.br"

  ##RESOURCES
  config.complete_payment_slip_resource, "/v2/sales/"
  config.simplified_credit_card_resource, "/v2/sales/"
  config.cancel_resource, "/v2/sales/"
end
