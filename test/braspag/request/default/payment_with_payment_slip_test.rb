require 'test/unit'


class PaymentWithPaymentSlipTest < Test::Unit::TestCase
  # def test_should_not_response_for_installments_methods
  #   pwps = new_pwps
  #   assert_equal(false, pwps.respond_to?(:installments))
  # end

  def test_should_not_exists_instance_variable_installments
    pwps = new_pwps

    assert_equal(false, pwps.instance_variables.include?("@installments"))
  end

  private
  def new_pwps
    KBraspag::Request::Default::PaymentWithPaymentSlip.new
  end
end
