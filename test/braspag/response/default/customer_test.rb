require 'test/unit'
require 'test/helpers/test_helper'
require 'test/fake_object/response/fake_customer'
require 'braspag/response/default/customer'

class CustomerTest < Test::Unit::TestCase
  include TestHelper

  def test_should_convert_default_hash_to_customer_object
    fake = FakeCustomer.new.default_hash
    customer = KBraspag::Response::Default::Customer.new(fake)

    each_expected_and_returned(fake, customer) do |expected, returned|
      assert_equal(expected, returned)
    end
  end
end
