class FakeCustomer
  def self.default_name!(customer)
    customer.name = "José da Silva"
    customer.identification = "1234567890"
    customer
  end
end
