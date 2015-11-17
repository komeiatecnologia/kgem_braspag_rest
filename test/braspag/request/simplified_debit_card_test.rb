require 'test/unit'

class SimplifiedDebitCardTest < Test::Unit::TestCase

  def test_should_return_valid_instance_of_simplified_credit_card_request
    sdc = new_sdc
    assert_equal(correct_payment_class, sdc.payment.class)
    assert_equal(correct_customer_class, sdc.customer.class)
    assert_equal(true, sdc.kind_of?(correct_ancestor_class))
  end

  def test_should_convert_to_braspag_hash_format
    sdc = new_sdc
    hash = sdc.to_braspag_hash
    assert_equal(Hash, hash['Customer'].class)
    assert_equal(Hash, hash['Payment'].class)
    assert_equal(Hash, hash['Payment']['DebitCard'].class)
    assert_equal(true, hash.key?('MerchantOrderId'))
  end

  private
  def new_sdc
    KBraspag::Request::SimplifiedDebitCard.new
  end

  def correct_payment_class
    KBraspag::Request::Default::PaymentWithDebitCard
  end

  def correct_customer_class
    KBraspag::Request::Default::Customer
  end

  def correct_ancestor_class
    KBraspag::Request::Default::Request
  end
end
