require 'lib/braspag/response/default/link'
class FakeLink
  def self.array_links
    a = []
    a << new_link({
          "Method" => "GET",
          "Rel" => "self",
          "Href" => "https://apiquerysandbox.braspag.com.br/v2/sales/{PaymentId}"
      })
    a << new_link({
          "Method" => "PUT",
          "Rel" => "capture",
          "Href" => "https://apisandbox.braspag.com.br/v2/sales/{PaymentId}/capture"
      })
    a << new_link({
          "Method" => "PUT",
          "Rel" => "void",
          "Href" => "https://apisandbox.braspag.com.br/v2/sales/{PaymentId}/void"
      })
  end

  def self.default_hash
    default_hash_array[Time.now.to_i % 3]
  end

  def self.default_hash_array
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

  private
  def new_link(hash)
    KBraspag::Response::Default::Link.new(hash)
  end
end
