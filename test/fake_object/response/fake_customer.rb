class FakeCustomer
  def default_hash
    @@default_hash ||= {'Name' => "Comprador Teste", 'Identification' => '12345678910'}
  end
end
