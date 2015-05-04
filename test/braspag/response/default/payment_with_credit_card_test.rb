require 'test/unit'
require 'test/helpers/test_helper'
require 'test/fake_object/response/fake_payment_with_credit_card'
require 'braspag/response/default/payment_with_credit_card'

class PaymentWithCreditCardTest < Test::Unit::TestCase
  include TestHelper

  def test_should_convert_default_hasht_to_payment_with_credit_card_object
    fake = FakePaymentWithCreditCard.new.default_hash
    pwcc = KBraspag::Response::PaymentWithCreditCard.new(fake)

    each_expected_and_returned(fake, pwcc) do |expected, returned|
      assert_equal(expected, returned) if verify_class?(returned)
    end
  end

  private
  def verify_class?(returned)
    !returned.kind_of? KBraspag::Response::Default::CreditCard
  end
end
