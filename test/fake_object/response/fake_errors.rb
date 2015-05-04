class FakeErrors
  def self.array_with_one_error
    [{'Code' => 1, 'Message' => 'Fake Error' }]
  end

  def self.array_with_two_error
    a = FakeErrors.array_with_one_error
    a << {'Code' => 2, 'Message' => 'Fake Error'}
    a
  end

  def self.array_with_three_error
    a = FakeErrors.array_with_two_error
    a << {'Code' => 2, 'Message' => 'Fake Error'}
    a
  end
end
