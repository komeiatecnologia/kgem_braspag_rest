require 'test/fake_object/response/fake_payment'
require 'test/fake_object/response/fake_link'
require 'test/fake_object/response/fake_debit_card'

class FakePaymentWithDebitCard
  def default_hash
    @@default_hash ||= build_hash
  end

  private
  def build_hash
    hash = FakePayment.new.default_hash
    hash['AcquirerTransactionId'] = "0305023644309"
    hash['Authenticate'] = false
    hash['DebitCard'] = FakeDebitCard.new.default_hash
    hash['Links'] = FakeLink.default_hash_array
    hash['PaymentId'] = "24bc8366-fc31-4d6c-8555-17049a836a07"
    hash['ReasonCode'] = 0
    hash['ReasonMessage'] = "Successful"
    hash["AuthorizationCode"]= "923923"
    hash["ReceivedDate"] = "2015-07-15 09:16:40"
    hash['Type'] = "DebitCard"
    hash
  end
end
