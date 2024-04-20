class Debt < ApplicationRecord
  belongs_to :person

  validates :amount, presence: true

  after_save :update_person_balance

  def to_s
    "
    Person ID: #{person_id},
    Amount: #{amount},
    Observation: #{observation},
    Created At: #{created_at},
    Updated At: #{updated_at}
    "
  end

  private

  def update_person_balance
    current_balance = person.balance || 0
    person.update(balance: current_balance + amount)
  end
end
