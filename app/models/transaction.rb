class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :amount, numericality: { greater_than: 0 }
end
