class Article < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :comments, dependent: :destroy
  has_many :transactions
end
