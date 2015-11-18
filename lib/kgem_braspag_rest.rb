require 'rubygems'
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
require 'helpers/helpers_class'
require 'helpers/helpers'
require 'helpers/meta'

require 'braspag/pagador/pagador'

require 'braspag/request/default/address'
require 'braspag/request/default/request'
require 'braspag/request/default/payment'
require 'braspag/request/default/card'
require 'braspag/request/default/debit_card'
require 'braspag/request/default/credit_card'
require 'braspag/request/default/customer'
require 'braspag/request/default/payment_with_debit_card'
require 'braspag/request/default/payment_with_credit_card'
require 'braspag/request/default/payment_with_payment_slip'
require 'braspag/request/default/payment_with_complete_payment_slip'

require 'braspag/response/default/response'
require 'braspag/response/default/errors'
require 'braspag/response/default/link'
require 'braspag/response/default/payment'
require 'braspag/response/default/card'
require 'braspag/response/default/credit_card'
require 'braspag/response/default/debit_card'
require 'braspag/response/default/customer'
require 'braspag/response/default/address'
require 'braspag/response/default/payment_with_credit_card'
require 'braspag/response/default/payment_with_debit_card'
require 'braspag/response/default/payment_with_payment_slip'

require 'braspag/response/cancel'
require 'braspag/response/complete_payment_slip'
require 'braspag/response/simplified_credit_card'
require 'braspag/response/simplified_debit_card'
require 'braspag/response/query'

require 'braspag/request/cancel'
require 'braspag/request/complete_payment_slip'
require 'braspag/request/simplified_credit_card'
require 'braspag/request/simplified_debit_card'
require 'braspag/request/query'

require 'braspag/webservice/cancel'
require 'braspag/webservice/complete_payment_slip'
require 'braspag/webservice/rest_client'
require 'braspag/webservice/simplified_credit_card'
require 'braspag/webservice/simplified_debit_card'
require 'braspag/webservice/query'

require 'payment/cancel'
require 'payment/complete_payment_slip'
require 'payment/simplified_credit_card'
require 'payment/simplified_debit_card'
require 'payment/query'

KLog::Log.configuration {|config| config.label = "Braspag Pagador API Rest [#{Time.now}]"}

module KBraspag
  extend Configuration

  SimplifiedCreditCard = Payment::SimplifiedCreditCard
  SCC = SimplifiedCreditCard

  SimplifiedDebitCard = Payment::SimplifiedDebitCard
  SDC = SimplifiedDebitCard

  CompletePaymentSlip = Payment::CompletePaymentSlip
  CPS = CompletePaymentSlip

  Cancel = Payment::Cancel
  C = Cancel

  Query = Payment::Query
  Q = Query

  ## FILE PATH TO CA CERTIFICATE (*.pem)
  define_setting :ca_file_path, "#{File.dirname(__FILE__)}/braspag.pem"

  ## PAYMENT METHODS AVAILABLE
  define_setting :payment_types, {
                                  :credit_card => "CreditCard",
                                  :debit_card => "DebitCard",
                                  # :eletronic_transfer => "EletronicTransfer",
                                  :payment_slip => "Boleto"
                                 }

  ## CREDIT CARD BRANDS AVAILABLE
  define_setting :credit_card_brands, {
                                        :visa => 'Visa',
                                        :mastercard => 'Master',
                                        :amex => 'Amex',
                                        :elo => 'Elo',
                                        :aura => 'Aura',
                                        :jcb => 'JCB',
                                        :diners => 'Diners',
                                        :discover => 'Discover',
                                        :hipercard => 'Hipercard',
                                        :hiper => 'Hiper'
                                      }

  define_setting :debit_card_brands, {
                                        :visa => "Visa",
                                        :mastercard => "Master"
                                      }

  ## CREDIT CARD PROVIDERS AVAILABLE
  define_setting :credit_card_providers, {
                                           :simulado => "Simulado",
                                           :cielo => "Cielo",
                                           :rede => "Redecard"
                                         }

  ## DEBIT CARD PROVIDERS AVAILABLE
  define_setting :debit_card_providers, {
                                          :simulado => "Simulado",
                                          :cielo => "Cielo"
                                        }

  ## AVAILABLE OPTIONS FOR RESPONSIBLE FOR INSTALLMENT SALES MADE BY CREDIT CARD
  define_setting :responsible_for_installment, {
                                                  :merchant => "ByMerchant",
                                                  :issuer => "ByIssuer"
                                               }

  define_setting :payment_slip_providers, {
                                            :bradesco => "Bradesco",
                                            :banco_do_brasil => "BancoDoBrasil",
                                            :citibank => "CitiBank",
                                            :itau => "Itau",
                                            :brb => "Brb",
                                            :caixa => "Caixa",
                                            :santander => "Santander",
                                            :hsbc => "HSBC",
                                            :simulado => "Simulado"
                                          }
  # define_setting :eletronic_transfer_providers, {
  #                                                 :bradesco => "Bradesco",
  #                                                 :simulado => "Simulado"
  #                                               }

  ##REQUEST SETTINGS
  define_setting :timeout, 15
  # Development merchant
  # define_setting :merchant_id, "e895fcba-14df-49f6-a019-e576c136f520"
  # define_setting :merchant_key, "FLKAVCQRLZKEZFFSDOYDBXPMWSUYWFSCMGDNKYYJ-"
  define_setting :merchant_id, nil
  define_setting :merchant_key, nil

  define_setting :connection_attempts, 3

  #URLs
  # define_setting :payment_url, "https://apisandbox.braspag.com.br"
  # define_setting :query_url, "https://apiquerysandbox.braspag.com.br"

  # Production URLs
  define_setting :payment_url, "https://api.braspag.com.br"
  define_setting :query_url, "https://apiquery.braspag.com.br"

  ##RESOURCES
  define_setting :complete_payment_slip_resource, "/v2/sales/"
  define_setting :simplified_credit_card_resource, "/v2/sales/"
  define_setting :simplified_debit_card_resource, "/v2/sales/"
  define_setting :cancel_resource, "/v2/sales/"
  define_setting :query_resource, "/v2/sales/"

  ## DEFAULT RESPONSIBLE INSTALLMENTS
  define_setting :interest, :issuer
end

