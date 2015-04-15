require 'test/fake_object/fake_payment'
require 'test/fake_object/fake_link'
require 'test/fake_object/fake_credit_card'

class FakePaymentWithCreditCard
  def initialize_hash
    @@initialize_hash ||= build_hash
  end

  private
  def build_hash
    hash = FakePayment.new.initialize_hash
    hash['AcquirerTransactionId'] = "0305023644309"
    hash['Authenticate'] = false
    hash['Capture'] = false
    hash['CreditCard'] = FakeCreditCard.new.initialize_hash
    hash['Installments'] = 1
    hash['Interest'] = "ByMerchant"
    hash['Links'] = FakeLink.array_of_hash
    hash['PaymentId'] = "24bc8366-fc31-4d6c-8555-17049a836a07"
    hash['ReasonCode'] = 0
    hash['ReasonMessage'] = "Successful"
    hash['ServiceTaxAmount'] = 0
    hash['Type'] = "CreditCard"
    hash
  end
end
