class FakeCustomer
  def self.default_name!(customer)
    customer.name = "José da Silva"
    customer.identity = "1234567890"
    customer.identity_type = "CPF"
    customer.email = "teste@teste.com.br"
    customer.birthdate = "1900-10-10"
    customer.address = FakeAddress.default!(customer.address)
    customer.delivery_address = FakeAddress.default_delivery!(customer.default_delivery)
    customer
  end
end
