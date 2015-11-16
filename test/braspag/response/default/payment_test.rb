require 'test/unit'
#require 'braspag/response/default/payment'
require 'test/fake_object/response/fake_payment'
require 'test/helpers/test_helper'

class PaymentTest < Test::Unit::TestCase
  include TestHelper

  def test_should_convert_default_hash_to_payment_object
    fake = FakePayment.new.default_hash
    payment = KBraspag::Response::Default::Payment.new(fake)

    each_expected_and_returned(fake, payment) do |expected, returned|
      assert_equal(expected, returned)
    end
  end
end
