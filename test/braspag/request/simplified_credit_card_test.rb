require 'test/unit'
# require 'lib/braspag/request/default/request'
# require 'lib/braspag/request/default/customer'
# require 'lib/braspag/request/default/payment_with_credit_card'
# require 'lib/braspag/request/simplified_credit_card'

class SimplifiedCreditCardTest < Test::Unit::TestCase

  def test_should_return_valid_instance_of_simplified_credit_card_request
    scc = new_scc
    assert_equal(correct_payment_class, scc.payment.class)
    assert_equal(correct_customer_class, scc.customer.class)
    assert_equal(true, scc.kind_of?(correct_ancestor_class))
  end

  def test_should_convert_to_braspag_hash_format
    scc = new_scc
    hash = scc.to_braspag_hash
    assert_equal(Hash, hash['Customer'].class)
    assert_equal(Hash, hash['Payment'].class)
    assert_equal(Hash, hash['Payment']['CreditCard'].class)
    assert_equal(true, hash.key?('MerchantOrderId'))
  end

  private
  def new_scc
    KBraspag::Request::SimplifiedCreditCard.new
  end

  def correct_payment_class
    KBraspag::Request::Default::PaymentWithCreditCard
  end

  def correct_customer_class
    KBraspag::Request::Default::Customer
  end

  def correct_ancestor_class
    KBraspag::Request::Default::Request
  end
end
