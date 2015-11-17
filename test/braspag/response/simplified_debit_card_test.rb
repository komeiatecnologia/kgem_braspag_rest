require 'test/unit'
require 'test/helpers/test_helper'
require 'test/fake_object/response/fake_simplified_debit_card'

require 'test/fake_object/response/fake_response'

class SimplifiedDebitCardTest < Test::Unit::TestCase
  include TestHelper

  IGNORED_CLASS = [
                    KBraspag::Response::PaymentWithDebitCard,
                    KBraspag::Response::Default::Customer
                  ]

  def test_should_convert_default_hash_to_simplified_debit_card_object
    each_expected_and_returned(fake_hash, fake_object) do |expected, returned|
      assert_equal(expected, returned) if verify_class?(returned)
    end
  end

  def test_should_return_correct_payment_with_debit_card_class
    pwdc = fake_object.payment
    assert_equal(IGNORED_CLASS[0], pwdc.class)
  end

  def test_should_return_correct_customer_class
    c = fake_object.customer
    assert_equal(IGNORED_CLASS[1], c.class)
  end

  def test_parse_success_braspag_response_body
    body = "{
    \"MerchantOrderId\": \"2014121201\",
    \"Customer\": {
        \"Name\": \"Paulo Henrique\"
    },
    \"Payment\": {
        \"DebitCard\": {
            \"CardNumber\": \"453211******3703\",
            \"Holder\": \"Teste Holder\",
            \"ExpirationDate\": \"12/2015\",
            \"SaveCard\": false,
            \"Brand\": \"Visa\"
        },
        \"AuthenticationUrl\": \"https://xxxxxxxxxxxx.xxxxx.xxx.xx/xxx/xxxxx.xxxx?{PaymentId}\",
        \"AcquirerTransactionId\": \"1006993069207A31A001\",
        \"PaymentId\": \"0309f44f-fe5a-4de1-ba39-984f456130bd\",
        \"Type\": \"DebitCard\",
        \"Amount\": 15700,
        \"ReceivedDate\": \"2015-03-25 09:36:20\",
        \"Currency\": \"BRL\",
        \"Country\": \"BRA\",
        \"Provider\": \"Cielo\",
        \"ReturnUrl\": \"http://www.braspag.com.br\",
        \"ReasonCode\": 9,
        \"ReasonMessage\": \"Waiting\",
        \"Status\": 0,
        \"ProviderReturnCode\": \"0\",
        \"Links\": [
            {
                \"Method\": \"GET\",
                \"Rel\": \"self\",
                \"Href\": \"https://apiquerysandbox.braspag.com.br/v2/sales/{PaymentId}\"
            }
        ]
    }
}"

    fake = FakeResponse.new.build_success(:body => body)

    res = sdc_class.build_response(fake)

    assert_equal reason_message[res.payment.reason_code], res.messages.first
    assert_equal 3, res.messages.size
    assert_equal "https://xxxxxxxxxxxx.xxxxx.xxx.xx/xxx/xxxxx.xxxx?{PaymentId}", res.payment.authentication_url
    assert_equal "0", res.payment.provider_return_code
    assert_equal Array, res.payment.links.class
    assert_equal true, res.payment.links.first.respond_to?(:rel)
    assert_equal "0309f44f-fe5a-4de1-ba39-984f456130bd", res.payment.payment_id
    assert_equal false, res.paid?
    assert_equal false, res.success?
  end

  private
  def verify_class?(returned)
    !IGNORED_CLASS.include? returned.class
  end

  def fake_hash
    FakeSimplifiedDebitCard.new.default_hash
  end

  def fake_object
    KBraspag::Response::SimplifiedDebitCard.new(fake_hash)
  end

  def sdc_class
    KBraspag::Response::SimplifiedDebitCard
  end

  def reason_message
    KBraspag::Pagador::REASON_MESSAGE
  end
end
