require 'test/unit'
require 'lib/helpers/helpers'
require 'lib/braspag/request/cancel'

class CancelTest < Test::Unit::TestCase
  include KBraspag::Helpers

  def test_should_throw_invalid_payment_id_when_receive_nil
    cancel = new_cancel
    begin
      cancel.payment_id = nil
    rescue Exception => e
      assert_equal msg_invalid_class(nil, String), e.message
    end
  end

  def test_should_throw_invalid_payment_id_when_receive_12345678
    cancel = new_cancel
    begin
      cancel.payment_id = 12345678
    rescue Exception => e
      assert_equal msg_invalid_class(12345678, String), e.message
    end
  end

  def test_should_throw_invalid_payment_id_when_receive_123h1j2hk3hkj1h2j3
    cancel = new_cancel
    begin
      cancel.payment_id = "123h1j2hk3hkj1h2j3"
    rescue Exception => e
      assert_equal "Invalid payment_id, expected xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", e.message
    end
  end

  def test_should_throw_invalid_payment_id_when_receive_234hkjhk_h1kj23h_12345678
    cancel = new_cancel
    begin
      cancel.payment_id = "234hkjhk_h1kj23h_12345678"
    rescue Exception => e
      assert_equal "Invalid payment_id, expected xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", e.message
    end
  end

  def test_should_return_66893a06_8bb9_42c6_b836_d73c5420941f
    cancel = new_cancel
    uuid = "66893a06-8bb9-42c6-b836-d73c5420941f"
    cancel.payment_id = uuid
    assert_equal uuid, cancel.payment_id
  end

  def test_should_throw_value_must_be_greater_than_zero_when_amount_reveice_0
    cancel = new_cancel
    begin
      cancel.amount  = 0
    rescue Exception => e
      assert_equal msg_less_or_equal_zero(0), e.message
    end
  end

  def test_should_throw_value_must_be_greater_than_zero_when_amount_reveice_negative_number
    cancel = new_cancel
    begin
      cancel.amount = -1
    rescue Exception => e
      assert_equal msg_less_or_equal_zero(-1), e.message
    end
  end

  def test_should_throw_invalid_class_when_amount_reveice_string_number
    cancel = new_cancel
    begin
      cancel.amount = "1"
    rescue Exception => e
      assert_equal msg_invalid_class("1", Numeric), e.message
    end
  end

  def test_should_return_10_when_amount_receive_10
    cancel = new_cancel
    cancel.amount = 10
    assert_equal 10, cancel.amount
  end

  def test_should_return_1011_when_receive_float_10_11
    cancel = new_cancel
    cancel.amount = 10.11
    assert_equal 1011, cancel.amount
  end

  def test_should_return_1011_when_receive_bigdecimal_10_11
    cancel = new_cancel
    cancel.amount = BigDecimal.new("10.11")
    assert_equal 1011, cancel.amount
  end

  def test_should_return_1011_when_receive_string_10_11
    cancel = new_cancel

    cancel.amount = "10,11"
    assert_equal 10_11, cancel.amount

    cancel.amount = "10.11"
    assert_equal 10_11, cancel.amount
  end

  def test_should_return_100011_when_receive_string_1000_11
    cancel = new_cancel

    cancel.amount = "1.000,11"
    assert_equal 1000_11, cancel.amount

    cancel.amount = "1,000,11"
    assert_equal 1000_11, cancel.amount
  end

  def test_should_return_1_000_000_000_11
    cancel = new_cancel

    cancel.amount = "1.000.000.000,11"
    assert_equal 1_000_000_000_11, cancel.amount

    cancel.amount = "1.000,000,000,11"
    assert_equal 1_000_000_000_11, cancel.amount

    cancel.amount = "1,000,000,000,11"
    assert_equal 1_000_000_000_11, cancel.amount

    cancel.amount = "1,000,000,000.11"
    assert_equal 1_000_000_000_11, cancel.amount
  end

  def test_should_throw_value_must_be_greater_than_zero_when_amount_reveice_negative_string_number
    cancel = new_cancel
    begin
      cancel.amount = "-1"
    rescue Exception => e
      assert_equal msg_less_or_equal_zero("-1"), e.message
    end
  end

  private
  def new_cancel
    KBraspag::Request::Cancel.new
  end
end