require 'test/unit'
# require 'lib/braspag/request/default/customer'
# require 'lib/helpers/helpers'

class DefaultCustomertTest < Test::Unit::TestCase
  # include KBraspag::Helpers

  def test_should_throw_exception_name_invalid_class_type
    c = new_customer
    begin
      name = :rafael_moraes
      c.name = name
    rescue Exception => e
      assert_equal c.msg_invalid_class(:name, String), e.message
    end
  end

  def test_should_throw_exception_name_can_not_be_empty
    c = new_customer
    begin
      c.name = ""
    rescue Exception => e
      assert_equal c.msg_can_not_be_empty("name"), e.message
    end
  end

  def test_should_return_name_equal_Carlos_Alberto
    c = new_customer
    name = "Carlos Alberto"
    c.name = name
    assert_equal name, c.name
  end

  def test_should_convert_default_customer_to_braspag_hash_format
    c = new_customer

    name = "Carlos Alberto"
    c.name = name

    braspag_hash = c.to_braspag_hash

    assert_equal name, braspag_hash['Name']
  end

  def test_should_throw_exception_identity_invalid_class_type
    c = new_customer
    begin
      id = 1234567890
      c.identity = id
    rescue Exception => e
      assert_equal c.msg_invalid_class(:identity, String), e.message
    end
  end

  def test_should_throw_exception_identity_can_not_be_empty
    c = new_customer
    begin
      c.identity = ""
    rescue Exception => e
      assert_equal c.msg_can_not_be_empty('identity'), e.message
    end
  end

  def test_should_throw_exception_identity_invalid_format
    c = new_customer
    id = "1234567890"
    begin
      c.identity = id
    rescue Exception => e
      msg = "Invalid identity, expected string with max 11 numeric characters(CPF/CPNJ)"
      assert_equal msg, e.message
    end
  end

  def test_should_return_identity_equal_12345678910
    c = new_customer
    id = "12345678910"
    c.identity = id
    assert_equal id, c.identity
  end

  def test_should_throw_exception_identity_type_invalid_class_type
    c = new_customer
    begin
      c.identity_type = :cpf
    rescue Exception => e
      assert_equal c.msg_invalid_class(:identity_type, String), e.message
    end
  end



  private
  def new_customer
    KBraspag::Request::Default::Customer.new
  end
end
