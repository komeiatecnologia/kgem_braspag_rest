require 'lib/helpers/configuration'
module KBraspag
  extend KBraspag::Configuration

  define_setting :brands, {
                          :visa => 'Visa', :mastercard => 'Mastercard',
                          :amex => 'Amex', :elo => 'Elo', :auria => 'Auria',
                          :jcb => 'JCB', :diners => 'Diners', :discover => 'Discover'
                        }

  define_setting :timeout, 5
  define_setting :payment_url, "https://apisandbox.braspag.com.br"
  define_setting :query_url, "https://apiquerysandbox.braspag.com.br"
  define_setting :merchant_id, "ba5908fb-87d1-4011-a158-02bec105aa15"
  define_setting :merchant_key, "GRGYVAUUNUWGIGSQKTNKNCFDKQVVGBYBDERAFHOG"
  # define_setting :request_id, "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  define_setting :connection_attempts, 3


end
