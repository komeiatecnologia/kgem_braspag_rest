require 'test/unit'
require 'lib/braspag/request/payment_with_credit_card'
require 'lib/braspag/request/default/credit_card'

class PaymentWithCreditCardTest < Test::Unit::TestCase

  def test_should_return_payment_with_credit_card_class
    p = new_payment_with_credit_card

    assert_equal KBraspag::Request::Default::CreditCard, p.credit_card.class
  end

  def test_should_convert_payment_with_credit_card_to_braspag_hash_format
    p = new_payment_with_credit_card

    hash = p.to_braspag_hash
    assert_equal Hash, hash['CreditCard'].class
  end

  private
  def new_payment_with_credit_card
    KBraspag::Request::PaymentWithCreditCard.new
  end
end
