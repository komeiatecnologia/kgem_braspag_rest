require 'test/unit'
require 'lib/braspag/response/default/payment'
require 'test/fake_object/fake_payment'
require 'lib/helpers/helpers'

class PaymentTest < Test::Unit::TestCase
  include KBraspag::Helpers

  def test_should_convert_hash_to_payment_object
    fake = FakePayment.new.default_hash
    payment = KBraspag::Response::Default::Payment.new(fake)

    payment.instance_variables.each do |m|
      method = m.gsub('@','')
      expected = fake[snakecase_to_braspagcase(method)]
      returned = payment.send(method.to_sym)

      assert_equal(returned, expected)
    end
  end
end
