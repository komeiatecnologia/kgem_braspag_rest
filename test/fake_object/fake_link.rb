class FakeLink
  def self.array_of_hash
    [
      {
          "Method" => "GET",
          "Rel" => "self",
          "Href" => "https://apiquerysandbox.braspag.com.br/v2/sales/{PaymentId}"
      },
      {
          "Method" => "PUT",
          "Rel" => "capture",
          "Href" => "https://apisandbox.braspag.com.br/v2/sales/{PaymentId}/capture"
      },
      {
          "Method" => "PUT",
          "Rel" => "void",
          "Href" => "https://apisandbox.braspag.com.br/v2/sales/{PaymentId}/void"
      }
    ]
  end
end
