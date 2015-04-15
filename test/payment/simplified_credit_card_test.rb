require 'test/unit'
require 'lib/braspag/payment/simplified_credit_card'

class SimplifiedCreditCardTest < Test::Unit::TestCase
  def test_should_convert_to_braspag_hash_format
    scc = new_scc
    hash = scc.to_braspag_hash

    assert_equal(false, true)
  end

  private
  def new_scc
    Braspag::Payment::SimplifiedCreditCard.new
  end
end
