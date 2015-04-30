module KBraspag
  require 'lib/helpers/configuration'
  require 'lib/payment/complete_payment_slip'
  require 'lib/payment/simplified_credit_card'

  SCC = Payment::SimplifiedCreditCard
  CPS = Payment::CompletePaymentSlip
  # autoload :SimplifiedCreditCard, 'lib/payment/simplified_credit_card'

  extend KBraspag::Configuration

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
  define_setting :merchant_id, "52c6e199-779a-4f38-98d5-14e6910a89ff"
  define_setting :merchant_key, "DOCIZAKQVEQPATZRFVNOEQVHOHSNPRUPAKYPYQFG"
  define_setting :connection_attempts, 3

  ##URLs
  define_setting :payment_url, "https://apisandbox.braspag.com.br"
  define_setting :query_url, "https://apiquerysandbox.braspag.com.br"

  ##RESOURCES
  define_setting :complete_payment_slip_resource, "/v2/sales/"
  define_setting :simplified_credit_card_resource, "/v2/sales/"
end
