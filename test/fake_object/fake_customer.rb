class FakeCustomer
  def default_hash
    @@default_hash ||= {'Name' => "Comprador Teste"}
  end
end
