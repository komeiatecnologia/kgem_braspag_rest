class FakePaymentWithPaymentSlip
  def self.default!(pwps)
    pwps.amount = 15700
    pwps.provider = "Simulado"
  end
end
