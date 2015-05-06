class FakeCustomer
  def self.default_name!(customer)
    customer.name = "José da Silva"
    customer
  end
end
