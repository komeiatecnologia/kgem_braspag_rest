class FakeErrors
  def self.array_with_one_error
    [{'Code' => 1, 'Message' => 'Fake Error' }]
  end

  def self.array_with_two_errors
    a = FakeErrors.array_with_one_error
    a << {'Code' => 2, 'Message' => 'Fake Error'}
    a
  end

  def self.array_with_three_errors
    a = FakeErrors.array_with_two_errors
    a << {'Code' => 3, 'Message' => 'Fake Error'}
    a
  end
end
