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
    each_expected_and_returned(fake_hash, fake_object) do |expected, returned|
      assert_equal(expected, returned) if verify_class?(returned)
    end
  end

  def test_should_return_valid_customer_class
    c = fake_object.customer
    assert_equal(IGNORED_CLASS[0], c.class)
  end

  def test_should_return_valid_payment_with_payment_slip_class
    pwps = fake_object.payment
    assert_equal(IGNORED_CLASS[1], pwps.class)
  end

  private
  def verify_class?(returned)
    !IGNORED_CLASS.include? returned.class
  end

  def fake_hash
    FakeCompletePaymentSlip.new.default_hash
  end

  def fake_object
    KBraspag::Response::CompletePaymentSlip.new(fake_hash)
  end
end
