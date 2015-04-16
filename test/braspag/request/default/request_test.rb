require 'test/unit'
require 'lib/braspag/request/default/request'
require 'lib/braspag/request/default/payment'
require 'lib/braspag/request/default/customer'
require 'lib/helpers/helpers'

class DefaultRequestTest < Test::Unit::TestCase
  include KBraspag::Helpers

  def test_should_throw_exception_merchant_order_id_invalid_class_type
    r = new_request
    id = 123456789
    begin
      r.merchant_order_id = id
    rescue Exception => e
      assert_equal msg_invalid_class(id, String), e.message
    end
  end

  def test_should_throw_exception_merchant_order_id_equal_empty
    r = new_request
    id = ""
    begin
      r.merchant_order_id = id
    rescue Exception => e
      assert_equal msg_can_not_be_empty("merchant_order_id"), e.message
    end
  end

  def test_should_throw_exception_merchant_order_id_invalid
    r = new_request
    id = "1234567ABC"
    begin
      r.merchant_order_id = id
    rescue Exception => e
      assert_equal "Invalid merchant_order_id: #{id}, expected only numbers", e.message
    end
  end

  def test_should_return_merchant_order_id_equal_123456789
    r = new_request
    id = "123456789"
    r.merchant_order_id = id
    assert_equal id, r.merchant_order_id
  end

  def test_should_throw_exception_customer_invalid_class_type
    r = new_request
    customer = {}
    begin
      r.customer = customer
    rescue Exception => e
      assert_equal msg_invalid_class(customer, customer_class), e.message
    end

    begin
      customer = "José da Silva"
      r.customer = customer
    rescue Exception => e
      assert_equal msg_invalid_class(customer, customer_class), e.message
    end
  end

  def test_should_return_customer_of_correct_class
    r = new_request
    r.customer = customer_class.new
    assert_equal r.customer.class, customer_class
  end

  def test_should_throw_exception_payment_invalid_class_type
    r = new_request
    payment = String
    begin
      r.payment = payment
    rescue Exception => e
      assert_equal msg_invalid_class(payment, payment_class), e.message
    end

    begin
      payment = {}
      r.payment = payment
    rescue Exception => e
      assert_equal msg_invalid_class(payment, payment_class), e.message
    end
  end

  def test_should_return_payment_of_corret_class
    r = new_request
    r.payment = payment_class.new
    assert_equal r.payment.class, payment_class
  end

  def test_should_convert_default_request_to_braspag_hash
    r = new_request
    id = '123456789'
    r.merchant_order_id = id
    r.customer = customer_class.new
    r.payment = payment_class.new

    braspag_hash = r.to_braspag_hash

    assert_equal id, braspag_hash['MerchantOrderId']
    assert_equal Hash, braspag_hash['Customer'].class
    assert_equal Hash, braspag_hash['Payment'].class
  end

  private
  def new_request
    KBraspag::Request::Default::Request.new
  end

  def payment_class
    KBraspag::Request::Default::Payment
  end

  def customer_class
    KBraspag::Request::Default::Customer
  end
end
