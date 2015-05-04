require 'test/unit'
require 'test/helpers/test_helper'
require 'test/fake_object/response/fake_complete_payment_slip'
require 'braspag/response/complete_payment_slip'

class CompletePaymentSlipTest < Test::Unit::TestCase
  include TestHelper

  IGNORED_CLASS = [
                    KBraspag::Response::Default::Customer,
                    KBraspag::Response::Default::PaymentWithPaymentSlip
                  ]

  def test_should_convert_hash_to_complete_payment_slip_object
    fake = FakeCompletePaymentSlip.new.default_hash
    cps = KBraspag::Response::CompletePaymentSlip.new(fake)

    each_expected_and_returned(fake, cps) do |expected, returned|
      assert_equal(expected, returned) if verify_class?(returned)
    end
  end

  private
  def verify_class?(returned)
    !IGNORED_CLASS.include? returned.class
  end
end
