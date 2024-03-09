class Debt < ApplicationRecord
  belongs_to :person

  validates :amount, presence: true

  def to_s
    "
    Person ID: #{person_id},
    Amount: #{amount},
    Observation: #{observation},
    Created At: #{created_at},
    Updated At: #{updated_at}
    "
  end
end
