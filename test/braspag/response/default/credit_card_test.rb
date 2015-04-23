require 'test/unit'
require 'test/fake_object/response/fake_credit_card'
require 'lib/braspag/response/default/credit_card'
require 'test/helpers/test_helper'

class CreditCardTest < Test::Unit::TestCase
  include TestHelper

  def test_should_convert_default_hash_to_credit_card_object
    fake = FakeCreditCard.new.default_hash
    credit_card = KBraspag::Response::Default::CreditCard.new(fake)

    each_expected_and_returned(fake, credit_card) do |expected, returned|
      assert_equal(expected, returned)
    end
  end
end
