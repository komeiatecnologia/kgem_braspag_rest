class FakeResponse
  def default_hash
    @@default_hash ||= {
                        "MerchantOrderId" => "2014111703",
                        "RequestId" => "00000000-0000-0000-0000-000000000000"
                       }
  end
end
