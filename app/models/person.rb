class Person < ApplicationRecord
  belongs_to :user, optional: true

  has_many :debts, dependent: :destroy

  validates :name, :national_id, presence: true
  validates :national_id, uniqueness: true
  validate :cpf_or_cnpj

  # TODO: refactor me
  #
  # - improve performance using SQL
  # - sum payments
  # - rename to "balance"
  def total_debts
    total = 0

    debts.each do |debt|
      total -= debt.amount
    end

    total
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
