require 'test/unit'
require 'test/helpers/test_helper'
require 'test/fake_object/response/fake_payment_with_payment_slip'
require 'lib/braspag/response/default/payment_with_payment_slip'

class PaymentWithPaymentSlipTest < Test::Unit::TestCase
  include TestHelper

  IGNORED_CLASS = [Array]

  def test_should_convert_default_hash_to_payment_with_payment_slip_object
    fake = FakePaymentWithPaymentSlip.new.default_hash
    pwps = KBraspag::Response::Default::PaymentWithPaymentSlip.new(fake)

    each_expected_and_returned(fake, pwps) do |expected, returned|
      assert_equal(expected, returned) if verify_class?(returned)
    end
  end

  def verify_class?(returned)
    !IGNORED_CLASS.include? returned.class
  end
end
