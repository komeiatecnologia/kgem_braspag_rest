require 'test/unit'
require 'lib/braspag/response/default/errors'
require 'test/fake_object/response/fake_errors'

class ErrorsTest < Test::Unit::TestCase
  def test_should_return_success_equal_false
    e = new_errors(FakeErrors.array_with_one_error)
    assert_equal false, e.success?
  end

  def test_should_return_one_error
    e = new_errors(FakeErrors.array_with_one_error)

    assert_equal 1, e.errors.size
  end
  private
  def new_errors(array)
    KBraspag::Response::Default::Errors.new(array)
  end
end
