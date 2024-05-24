class BalanceCalculationService
  def call
    active_people_ids = Person.where(active: true).pluck(:id)
    total_debts = Debt.where(person_id: active_people_ids).sum(:amount)
    total_payments = Payment.where(person_id: active_people_ids).sum(:amount)
    balance = total_payments - total_debts
    [total_debts, total_payments, balance]
  end
end