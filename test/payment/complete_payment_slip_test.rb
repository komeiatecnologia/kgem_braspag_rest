require 'test/unit'
require 'test/fake_object/request/fake_complete_payment_slip'
require 'lib/payment/complete_payment_slip'
require 'lib/helpers/helpers'

class CompletePaymentSlipTest < Test::Unit::TestCase
  include KBraspag::Helpers

  def test_should_throw_payment_identification_can_not_be_empty
    cps = fake_obj
    cps.payment.instance_variable_set(:@identification, nil)
    begin
      cps.pay
    rescue Exception => e
      assert_equal msg_can_not_be_empty("identification"), e.message
    end
  end

  def test_should_throw_customer_name_can_not_be_empty
    cps = fake_obj
    cps.customer.instance_variable_set(:@name, nil)
    begin
      cps.pay
    rescue Exception => e
      assert_equal msg_can_not_be_empty("name"), e.message
    end
  end

  def test_should_throw_merchant_order_id_can_not_be_empty
    cps = fake_obj
    cps.instance_variable_set(:@merchant_order_id, nil)
    begin
      cps.pay
    rescue Exception => e
      assert_equal msg_can_not_be_empty("merchant_order_id"), e.message
    end
  end

  def test_should_return_correct_braspag_hash
    cps = fake_obj
    hash = cps.to_braspag_hash
    assert_equal cps.merchant_order_id, hash['MerchantOrderId']
    assert_equal cps.customer.class, KBraspag::Request::Default::Customer
    assert_equal cps.customer.name, hash['Customer']['Name']
    assert_equal cps.payment.class, KBraspag::Request::Default::PaymentWithCompletePaymentSlip
    assert_equal cps.payment.amount, hash['Payment']['Amount']
    assert_equal cps.payment.provider, hash['Payment']['Provider']
    assert_equal cps.payment.address, hash['Payment']['Address']
    assert_equal cps.payment.payment_slip_number, hash['Payment']['BoletoNumber']
    assert_equal cps.payment.assignor, hash['Payment']['Assignor']
    assert_equal cps.payment.demonstrative, hash['Payment']['Demonstrative']
    assert_equal cps.payment.expiration_date, hash['Payment']['ExpirationDate']
    assert_equal cps.payment.identification, hash['Payment']['Identification']
    assert_equal cps.payment.instructions, hash['Payment']['Instructions']
  end

  def test_should_throw_can_not_be_empty_if_payment_equal_nil
    cps = fake_obj
    cps.instance_variable_set :@payment, nil
    begin
      cps.valid?
    rescue Exception => e
      assert_equal msg_can_not_be_empty("payment"), e.message
    end
  end

  def test_should_throw_can_not_be_empty_if_customer_equal_nil
    cps = fake_obj
    cps.instance_variable_set :@customer, nil
    begin
      cps.valid?
    rescue Exception => e
      assert_equal msg_can_not_be_empty("customer"), e.message
    end
  end

  def test_should_throw_payment_can_not_be_empty_when_try_pay
    cps = fake_obj
    cps.instance_variable_set :@payment, nil
    begin
      cps.pay
    rescue Exception => e
      assert_equal msg_can_not_be_empty("payment"), e.message
    end
  end

  def test_should_throw_customer_can_not_be_empty_when_try_pay
    cps = fake_obj
    cps.instance_variable_set :@customer, nil
    begin
      cps.pay
    rescue Exception => e
      assert_equal msg_can_not_be_empty("customer"), e.message
    end
  end

  private
  def new_cps
    KBraspag::Payment::CompletePaymentSlip.new
  end

  def fake_obj
    cps = new_cps
    FakeCompletePaymentSlip.default! cps
    cps
  end
end