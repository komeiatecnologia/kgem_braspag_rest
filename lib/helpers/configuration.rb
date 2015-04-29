module KBraspag
  module Configuration
    def configuration
      yield self
    end

    def define_setting(name, default = nil)
      class_variable_set("@@#{name}", default)

      define_class_method "#{name}=" do |value|
        class_variable_set("@@#{name}", value)
      end

      define_class_method name do
        class_variable_get("@@#{name}")
      end
    end

    private
    def define_class_method(name, &block)
      (class << self; self; end).instance_eval do
        define_method name, &block
      end
    end
  end

  # extend Configuration

  # define_setting :BRANDS, {
  #                           :visa => 'Visa', :mastercard => 'Mastercard',
  #                           :amex => 'Amex', :elo => 'Elo', :auria => 'Auria',
  #                           :jcb => 'JCB', :diners => 'Diners', :discover => 'Discover'
  #                         }.freeze

  # define_setting :TIMEOUT, 5
  # # define_setting :PAYMENT_URL, URI("https://apisandbox.braspag.com.br")
  # # define_setting :QUERY_URL, URI("https://apiquerysandbox.braspag.com.br")
  # define_setting :MERCHANT_ID, "ba5908fb-87d1-4011-a158-02bec105aa15"
  # define_setting :MERCHANT_KEY, "GRGYVAUUNUWGIGSQKTNKNCFDKQVVGBYBDERAFHOG"
  # define_setting :REQUEST_ID, "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  # define_setting :CONNECTION_ATTEMPTS, 3

  # define_setting :PAYMENT_TYPES, {
  #                                 :credit_card => "CreditCard", :debit_card => "DebitCard",
  #                                 :eletronic_transfer => "EletronicTransfer", :payment_slip => "Boleto"
  #                                }.freeze
end
