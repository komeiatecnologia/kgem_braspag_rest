require 'test/fake_object/fake_customer'
require 'test/fake_object/fake_payment_with_credit_card'

class FakeSimplifiedCreditCard
  def initialize_hash
    @@initialize_hash ||= build_hash
  end

  private
  def build_hash
    h = {
          'Customer' => FakeCustomer.initialize_hash,
          'MerchantOrderId' => "2014111706",
          'Payment' => FakePaymentWithCreditCard.new.initialize_hash
        }
    h['Payment']['ProofOfSale'] = "674532"
    h['Payment']['AuthorizationCode'] = "123456"
    h['Payment']['ProviderReturnCode'] = "4"
    h['Payment']['ProviderReturnMessage'] = "Operation Successful"
    h
  end
end
