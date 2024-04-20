class Person < ApplicationRecord
  belongs_to :user, optional: true

  has_many :debts, dependent: :destroy
  has_many :payments, dependent: :destroy

  validates :name, :national_id, presence: true
  validates :national_id, uniqueness: true
  validate :cpf_or_cnpj

  def to_s
    "
    Name: #{name},
    National ID: #{national_id},
    Phone Number: #{phone_number},
    Balance: #{balance},
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
