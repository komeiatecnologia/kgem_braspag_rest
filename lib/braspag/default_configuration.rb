require 'lib/helpers/configuration'
module KBraspag
  extend KBraspag::Configuration

  ## PAYMENT METHODS AVAILABLE
  define_setting :payment_types, {
                                  :credit_card => "CreditCard", :debit_card => "DebitCard",
                                  :eletronic_transfer => "EletronicTransfer", :payment_slip => "Boleto"
                                 }

  ## CREDIT CARD BRANDS AVAILABLE
  define_setting :brands, {
                            :visa => 'Visa', :mastercard => 'Mastercard',
                            :amex => 'Amex', :elo => 'Elo', :auria => 'Auria',
                            :jcb => 'JCB', :diners => 'Diners', :discover => 'Discover'
                          }

  ## AVAILABLE PROVIDERS LIST
  define_setting :credit_card_providers, {
                                           :simulado => "Simulado",
                                           :cielo => "Cielo",
                                           :rede => "Redecard"
                                         }
  define_setting :debit_providers, {:cielo => "Cielo"}
  define_setting :payment_slip_providers, {
                                            :bradesco => "Bradesco",
                                            :banco_do_brasil => "BancoDoBrasil",
                                            :citibank => "CitiBank",
                                            :itau => "Itau",
                                            :brb => "Brb",
                                            :caixa => "Caixa",
                                            :simulado => "Simulado"
                                          }
  define_setting :eletronic_transfer_providers, {
                                                  :bradesco => "Bradesco",
                                                  :simulado => "Simulado"
                                                }

  ##REQUEST SETTINGS
  define_setting :timeout, 5
  define_setting :merchant_id, "e895fcba-14df-49f6-a019-e576c136f520"
  define_setting :merchant_key, "FLKAVCQRLZKEZFFSDOYDBXPMWSUYWFSCMGDNKYYJ"
  define_setting :connection_attempts, 3

  ##URLs
  define_setting :payment_url, "https://apisandbox.braspag.com.br"
  define_setting :query_url, "https://apiquerysandbox.braspag.com.br"

  ##RESOURCES
  define_setting :complete_payment_slip_resource, "/v2/sales/"
  define_setting :simplified_credit_card_resource, "/v2/sales/"
  define_setting :cancel_resource, "/v2/sales/"
end