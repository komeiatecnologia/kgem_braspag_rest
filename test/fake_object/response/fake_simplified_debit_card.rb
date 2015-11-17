require 'test/fake_object/response/fake_customer'
require 'test/fake_object/response/fake_payment_with_debit_card'

class FakeSimplifiedDebitCard
  def default_hash
    @@default_hash ||= build_hash
  end

  private
  def build_hash
    h = {
          'Customer' => FakeCustomer.new.default_hash,
          'MerchantOrderId' => "2014111706",
          'Payment' => FakePaymentWithDebitCard.new.default_hash
        }
    h['Payment']['ProofOfSale'] = "674532"
    h['Payment']['AuthorizationCode'] = "123456"
    h['Payment']['ProviderReturnCode'] = "4"
    h['Payment']['ProviderReturnMessage'] = "Operation Successful"
    h
  end
end
