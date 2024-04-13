class Person < ApplicationRecord
  belongs_to :user, optional: true

  has_many :debts, dependent: :destroy
  has_many :payments, dependent: :destroy

  validates :name, :national_id, presence: true
  validates :national_id, uniqueness: true
  validate :cpf_or_cnpj

  def balance
    Rails.cache.fetch("person_#{id}_balance") do
      debts_sum = debts.sum(:amount)
      payments_sum = payments.sum(:amount)
      debts_sum - payments_sum
    end
  end

  def update_cached_balance
    Rails.cache.write("person_#{id}_balance", balance)
  end

  def to_s
    "
    Name: #{name},
    National ID: #{national_id},
    Phone Number: #{phone_number},
    Active: #{active},
    User: #{user_id},
    Created At: #{created_at},
    Updated At: #{updated_at}
    "
  end

  private

  def cpf_or_cnpj
    if !CPF.valid?(national_id) && !CNPJ.valid?(national_id)
      errors.add :national_id, :invalid
    end
  end
end
