require 'test/unit'
require 'lib/braspag/model/default/customer'
require 'lib/helpers/helpers'

class DefaultCustomertTest < Test::Unit::TestCase
  include Braspag::Helpers

  def test_should_throw_exception_name_invalid_class_type
    c = new_customer
    begin
      name = Object.new
      c.name = name
    rescue Exception => e
      assert_equal msg_invalid_class(name, String), e.message
    end
  end

  def test_should_throw_exception_name_can_not_be_empty
    c = new_customer
    begin
      c.name = ""
    rescue Exception => e
      assert_equal msg_can_not_be_empty("name"), e.message
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

  private
  def new_customer
    Braspag::Model::Default::Customer.new
  end
end
