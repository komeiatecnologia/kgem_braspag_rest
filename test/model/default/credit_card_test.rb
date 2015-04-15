require 'test/unit'
require 'lib/braspag/model/default/credit_card'
require 'lib/helpers/helpers'

class CreditCardTest < Test::Unit::TestCase
  include Braspag::Helpers

  def test_should_throw_exception_if_card_number_class_different_of_string
    c = new_credit_card
    begin
      n = 1234566
      c.card_number = n
    rescue Exception => e
      assert_equal msg_invalid_class(n,String), e.message
    end

    begin
      n = 1.2
      c.card_number =n
    rescue Exception => e
      assert_equal msg_invalid_class(n,String), e.message
    end
  end

  def test_should_throw_exception_when_invalid_card_number_format
    c = new_credit_card
    begin
      n = "000000001111"
      c.card_number = n
    rescue Exception => e
      assert_equal "Invalid card number format: #{n}, expected 1111222233334444(16 digits)", e.message
    end

    begin
      n = ""
      c.card_number = n
    rescue Exception => e
      assert_equal msg_can_not_be_empty("card_number"), e.message
    end
  end

  def test_should_return_card_number_equals_0000111122223333
    c = new_credit_card
    c.card_number = "0000111122223333"
    assert_equal "0000111122223333", c.card_number
  end

  def test_should_throw_exception_if_holder_class_different_of_string
    begin
      c = new_credit_card
      h = :teste
      c.holder = h
    rescue Exception => e
      assert_equal msg_invalid_class(h, String), e.message
    end

    begin
      c = new_credit_card
      h = 234234
      c.holder = h
    rescue Exception => e
      assert_equal msg_invalid_class(h,String), e.message
    end
  end

  def test_should_throw_exception_if_holder_empty
    begin
      c = new_credit_card
      c.holder = ""
    rescue Exception => e
      assert_equal msg_can_not_be_empty("holder"), e.message
    end
  end

  def test_should_return_holder_equals_Jon_Doe
    c = new_credit_card
    h = "Jon Doe"
    c.holder = h
    assert_equal h, c.holder
  end

  def test_should_throw_exception_if_expiration_date_class_different_of_string
    c = new_credit_card
    begin
      d = Time.now
      c.expiration_date = d
    rescue Exception => e
      assert_equal msg_invalid_class(d, String), e.message
    end
  end

  def test_should_throw_exception_if_expiration_date_empty
    c = new_credit_card
    begin
      a = ""
      c.expiration_date = a
    rescue Exception => e
      assert_equal msg_can_not_be_empty("expiration_date"), e.message
    end
  end

  def test_should_return_expiration_date_equal_1_slash_2020
    c = new_credit_card
    d = "1/2020"
    c.expiration_date = d
    assert_equal d, c.expiration_date
  end

  def test_should_return_expiration_date_equal_11_slash_2020
    c = new_credit_card
    d = "11/2020"
    c.expiration_date = d
    assert_equal d, c.expiration_date
  end

  def test_should_throw_exception_if_security_code_class_different_of_string
    c = new_credit_card
    begin
      s = 123
      c.security_code = 123
    rescue Exception => e
      assert_equal msg_invalid_class(s, String), e.message
    end
  end

  def test_should_throw_exception_if_security_code_empty
    c = new_credit_card
    begin
      s = ""
      c.security_code = s
    rescue Exception => e
      assert_equal msg_can_not_be_empty("security_code"), e.message
    end
  end

  def test_should_return_security_code_equal_123
    c = new_credit_card
    s = "666"
    c.security_code = s
    assert_equal s, c.security_code
  end

  def test_should_throw_exception_if_brand_class_different_of_string
    c = new_credit_card
    begin
      b = :visa
      c.brand = b
    rescue Exception => e
      assert_equal msg_invalid_class(b, String), e.message
    end
  end

  def test_should_throw_exception_if_brand_not_registered
    c = new_credit_card
    begin
      b = :bandeira
      c.brand = b
    rescue Exception => e
      assert_equal true, true
    end
  end

  def test_should_return_brand_equal_Visa
    c = new_credit_card
    c.brand = "Visa"
    assert_equal "Visa", c.brand
  end

  def test_should_return_brand_equal_Mastercard
    c = new_credit_card
    c.brand = "Mastercard"
    assert_equal "Mastercard", c.brand
  end

  def test_should_return_brand_equal_Amex
    c = new_credit_card
    c.brand = "Amex"
    assert_equal "Amex", c.brand
  end

  def test_should_return_brand_equal_Elo
    c = new_credit_card
    c.brand ="Elo"
    assert_equal "Elo", c.brand
  end

  def test_should_return_brand_equal_Auria
    c = new_credit_card
    c.brand = "Auria"
    assert_equal "Auria", c.brand
  end

  def test_should_return_brand_equal_JCB
    c = new_credit_card
    c.brand = "JCB"
    assert_equal "JCB", c.brand
  end

  def test_should_return_brand_equal_Diners
    c = new_credit_card
    c.brand = "Diners"
    assert_equal "Diners", c.brand
  end

  def test_should_return_brand_equal_Discover
    c = new_credit_card
    c.brand = "Discover"
    assert_equal "Discover", c.brand
  end

  def test_should_convert_credit_card_to_braspag_hash_format
    c = new_credit_card

    card_number = "1111222233334444"
    c.card_number = card_number

    holder = "José da Silva"
    c.holder = holder

    expiration_date = "10/2020"
    c.expiration_date = expiration_date

    security_code = "123"
    c.security_code = security_code

    brand = "Visa"
    c.brand = brand

    braspag_hash = c.to_braspag_hash

    assert_equal(card_number, braspag_hash["CardNumber"])
    assert_equal(holder, braspag_hash['Holder'])
    assert_equal(expiration_date, braspag_hash['ExpirationDate'])
    assert_equal(security_code, braspag_hash['SecurityCode'])
    assert_equal("Visa", braspag_hash['Brand'])
  end

  def test_should_show_all_brands
    assert_equal(Braspag::Model::Default::CreditCard.all_brands.class, Array)
  end

private
  def new_credit_card
    Braspag::Model::Default::CreditCard.new
  end
end
