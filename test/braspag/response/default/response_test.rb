require 'test/unit'
require 'test/helpers/test_helper'
require 'test/fake_object/response/fake_response'
require 'lib/braspag/response/default/response'

class ResponseTest < Test::Unit::TestCase
  include TestHelper

  def test_should_convert_default_hash_to_response_object
    fake = FakeResponse.new.default_hash
    response = KBraspag::Response::Default::Response.new(fake)

    each_expected_and_returned(fake, response) do |expected, returned|
      assert_equal(expected, returned)
    end
  end
end
