class LastPaymentsService
  def call
    Payment.order(created_at: :desc).limit(10).pluck(:id, :amount)
  end
end