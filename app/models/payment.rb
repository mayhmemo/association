class Payment < ApplicationRecord
  belongs_to :person

  validates :amount, presence: true

  after_save :update_person_balance_cache

  private

  def update_person_balance_cache
    person.update_cached_balance
  end
end
