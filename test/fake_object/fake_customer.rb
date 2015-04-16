class FakeCustomer
  def self.default_hash
    @@default_hash ||= {'Name' => "Comprador Teste"}
  end
end
