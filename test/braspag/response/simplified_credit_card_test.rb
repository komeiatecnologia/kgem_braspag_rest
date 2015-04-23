require 'test/unit'
require 'test/helpers/test_helper'
require 'test/fake_object/response/fake_simplified_credit_card'
require 'braspag/response/simplified_credit_card'

class SimplifiedCreditCardTest < Test::Unit::TestCase
  include TestHelper

  IGNORED_CLASS = [
                    KBraspag::Response::PaymentWithCreditCard,
                    KBraspag::Response::Default::Customer
                  ].freeze

  def test_should_convert_default_hash_to_simplified_credit_card_object
    fake = FakeSimplifiedCreditCard.new.default_hash
    scc = KBraspag::Response::SimplifiedCreditCard.new(fake)

    each_expected_and_returned(fake, scc) do |expected, returned|
      assert_equal(expected, returned) if verify_class?(returned)
    end
  end

  private
  def verify_class?(returned)
    !IGNORED_CLASS.include? returned.class
  end
end
