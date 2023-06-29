# frozen_string_literal: true

class BookCategory < ApplicationRecord
  belongs_to :category
  belongs_to :book
end
