require 'net/http'
require 'net/https'
require 'openssl'
require 'securerandom'
require 'date'
require 'bigdecimal'
require 'bigdecimal/util'
require 'kgem_log'
require 'json'

require 'helpers/configuration'
require 'helpers/helpers'
require 'helpers/meta'

require 'braspag/pagador/pagador'

require 'braspag/request/default/request'
require 'braspag/request/default/payment'
require 'braspag/request/default/credit_card'
require 'braspag/request/default/customer'
require 'braspag/request/default/payment_with_credit_card'
require 'braspag/request/default/payment_with_payment_slip'
require 'braspag/request/default/payment_with_complete_payment_slip'


require 'braspag/response/default/response'
require 'braspag/response/default/errors'
require 'braspag/response/default/link'
require 'braspag/response/default/payment'
require 'braspag/response/default/credit_card'
require 'braspag/response/default/customer'
require 'braspag/response/default/payment_with_credit_card'
require 'braspag/response/default/payment_with_payment_slip'


require 'braspag/response/cancel'
require 'braspag/response/complete_payment_slip'
require 'braspag/response/simplified_credit_card'

require 'braspag/request/cancel'
require 'braspag/request/complete_payment_slip'
require 'braspag/request/simplified_credit_card'

require 'braspag/webservice/cancel'
require 'braspag/webservice/complete_payment_slip'
require 'braspag/webservice/rest_client'
require 'braspag/webservice/simplified_credit_card'

require 'payment/cancel'
require 'payment/complete_payment_slip'
require 'payment/simplified_credit_card'


module KBraspag
  extend Configuration

  SimplifiedCreditCard = Payment::SimplifiedCreditCard
  SCC = SimplifiedCreditCard

  CompletePaymentSlip = Payment::CompletePaymentSlip
  CPS = CompletePaymentSlip

  Cancel = Payment::Cancel
  C = Cancel

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

