require 'test/unit'

class PaymentWithDebitCardTest < Test::Unit::TestCase

  def test_should_return_payment_with_debit_card_class
    p = new_payment_with_debit_card

    assert_equal KBraspag::Request::Default::DebitCard, p.debit_card.class
  end

  def test_should_convert_payment_with_debit_card_to_braspag_hash_format
    p = new_payment_with_debit_card

    hash = p.to_braspag_hash
    assert_equal Hash, hash['DebitCard'].class
    assert_equal true, hash.key?('ReturnUrl')
  end

  private
  def new_payment_with_debit_card
    KBraspag::Request::Default::PaymentWithDebitCard.new
  end
end
