class Category < ApplicationRecord
  belongs_to :user

  has_many :book_categories, dependent: :destroy
  has_many :books, through: :book_categories, dependent: :destroy
end
