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

  def test_should_throw_exception_identification_invalid_class_type
    c = new_customer
    begin
      id = 1234567890
      c.identification = id
    rescue Exception => e
      assert_equal c.msg_invalid_class(:identification, String), e.message
    end
  end

  def test_should_throw_exception_identification_can_not_be_empty
    c = new_customer
    begin
      c.identification = ""
    rescue Exception => e
      assert_equal c.msg_can_not_be_empty('identification'), e.message
    end
  end

  def test_should_throw_exception_identification_invalid_format
    c = new_customer
    id = "1234567890"
    begin
      c.identification = id
    rescue Exception => e
      msg = "Invalid identification, expected string with max 11 numeric characters(CPF/CPNJ)"
      assert_equal msg, e.message
    end
  end

  def test_should_return_identification_equal_12345678910
    c = new_customer
    id = "12345678910"
    c.identification = id
    assert_equal id, c.identification
  end

  private
  def new_customer
    KBraspag::Request::Default::Customer.new
  end
end
