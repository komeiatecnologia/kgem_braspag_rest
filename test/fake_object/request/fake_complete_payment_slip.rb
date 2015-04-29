require 'test/fake_object/request/fake_customer'
require 'test/fake_object/request/fake_payment_with_payment_slip'

class FakeCompletePaymentSlip
  def self.default!(cps)
    FakeCustomer.default_name!(cps.customer)
    FakePaymentWithPaymentSlip.default!(cps.payment)
    cps.payment.address = "Rua Teste"
    cps.payment.payment_slip_number = "123"
    cps.payment.assignor = "Empresa Teste"
    cps.payment.demonstrative = "Desmonstrative Teste"
    cps.payment.expiration_date = "5/1/2020"
    cps.payment.identification = "11884926754"
    cps.payment.instructions = "Aceitar somente até a data de vencimento, após essa data juros de 1% dia."
    cps
  end
end
