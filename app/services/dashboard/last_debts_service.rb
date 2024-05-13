class LastDebtsService
  def call
    Debt.order(created_at: :desc).limit(10).pluck(:id, :amount)
  end
end