class TopPersonService
  def call
    people_with_positive_balance.last
  end

  private

  def people_with_positive_balance
    Person.where(balance: (0..Float::INFINITY)).order(:balance)
  end
end