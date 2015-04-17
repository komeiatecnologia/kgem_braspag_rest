class FakeResponse
  def default_hash
    @@default_hash ||= {"MerchantOrderId" => "2014111703"}
  end
end
