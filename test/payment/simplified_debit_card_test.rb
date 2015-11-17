require 'test/unit'
require 'test/fake_object/request/fake_simplified_debit_card'

class SimplifiedDebitCardTest < Test::Unit::TestCase
  include KBraspag::Helpers

  def test_should_throw_merchant_order_id_can_not_be_empty
    sdc = fake_obj
    sdc.instance_variable_set :@merchant_order_id, nil
    begin
      sdc.pay
    rescue Exception => e
      assert_equal sdc.msg_can_not_be_empty("merchant_order_id"), e.message
    end
  end

  def test_should_throw_customer_name_can_not_be_empty
    sdc = fake_obj
    sdc.customer.instance_variable_set :@name, nil
    begin
      sdc.pay
    rescue Exception => e
      assert_equal sdc.msg_can_not_be_empty("name"), e.message
    end
  end

  def test_should_return_correct_braspag_hash
    sdc = fake_obj
    hash = sdc.to_braspag_hash
    assert_equal sdc.merchant_order_id, hash['MerchantOrderId']
    assert_equal sdc.customer.class, KBraspag::Request::Default::Customer
    assert_equal sdc.customer.name, hash['Customer']['Name']
    assert_equal sdc.payment.class, KBraspag::Request::Default::PaymentWithDebitCard
    assert_equal sdc.payment.amount, hash['Payment']['Amount']
    assert_equal sdc.payment.return_url, hash['Payment']['ReturnUrl']
    assert_equal "Simulado", hash['Payment']['Provider']
    assert_equal sdc.payment.debit_card.class, KBraspag::Request::Default::DebitCard
    assert_equal sdc.payment.debit_card.card_number, hash['Payment']['DebitCard']['CardNumber']
    assert_equal sdc.payment.debit_card.holder, hash['Payment']['DebitCard']['Holder']
    assert_equal sdc.payment.debit_card.expiration_date, hash['Payment']['DebitCard']['ExpirationDate']
    assert_equal sdc.payment.debit_card.security_code, hash['Payment']['DebitCard']['SecurityCode']
    assert_equal sdc.payment.debit_card.brand, hash['Payment']['DebitCard']['Brand']
  end

  def test_should_throw_can_not_be_empty_if_payment_equal_nil
    sdc = fake_obj
    sdc.instance_variable_set :@payment, nil
    begin
      sdc.valid_?
    rescue Exception => e
      assert_equal sdc.msg_can_not_be_empty("payment"), e.message
    end
  end

  def test_should_throw_can_not_be_empty_if_customer_equal_nil
    sdc = fake_obj
    sdc.instance_variable_set :@customer, nil
    begin
      sdc.valid_?
    rescue Exception => e
      assert_equal sdc.msg_can_not_be_empty("customer"), e.message
    end
  end

  def test_should_throw_payment_can_not_be_empty_when_try_pay
    sdc = fake_obj
    sdc.instance_variable_set :@payment, nil
    begin
      sdc.pay
    rescue Exception => e
      assert_equal sdc.msg_can_not_be_empty("payment"), e.message
    end
  end

  def test_should_throw_payment_can_not_be_empty_when_try_pay
    sdc = fake_obj
    sdc.instance_variable_set :@payment, nil
    begin
      sdc.pay
    rescue Exception => e
      assert_equal sdc.msg_can_not_be_empty("payment"), e.message
    end
  end

  def test_should_throw_customer_can_not_be_empty_when_try_pay
    sdc = fake_obj
    sdc.instance_variable_set :@customer, nil
    begin
      sdc.pay
    rescue Exception => e
      assert_equal sdc.msg_can_not_be_empty("customer"), e.message
    end
  end

  private
  def new_sdc
    KBraspag::Payment::SimplifiedDebitCard.new
  end

  def fake_obj
    sdc = new_sdc
    FakeSimplifiedDebitCard.default! sdc
    sdc
  end
end
