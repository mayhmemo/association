class BottomPersonService
  def call
    people_with_positive_balance.first
  end

  private

  def people_with_positive_balance
    Person.where(balance: (0..Float::INFINITY)).order(:balance)
  end
end