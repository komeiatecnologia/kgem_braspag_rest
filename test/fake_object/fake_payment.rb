class FakePayment

  def initialize_hash
    @@initialize_hash ||= build_hash
  end

  private
  def build_hash
   {
      'Amount' => "15700",
      "Country" => "BRA",
      "Currency" => "BRL",
      "Provider" => "Simulado",
      "Status" => 1,
      "ExtraDataCollection" => []
   }
  end
end

