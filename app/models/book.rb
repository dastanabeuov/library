class Book < ApplicationRecord
  belongs_to :user

  has_many :book_categories
  has_many :categories, through: :book_categories

  #validates :main_pdf, presence: true
  validates :title, presence: true
  validates :author, presence: true
  validates :description, presence: true

  has_one_attached :main_pdf, dependent: :destroy
  validate :acceptable_pdf

private

  def self.ransackable_attributes(auth_object = nil)
    ["title", "author", "description"]
  end

  def acceptable_pdf
    return unless main_pdf.attached?

    ## if your need add limit from file
    # unless main_pdf.blob.byte_size <= 50.megabyte
    #   errors.add(:main_pdf, "Cлишком велик размер файла :-( Допустимо не более 50 мб")
    # end

    acceptable_types = ["application/pdf"]
    unless acceptable_types.include?(main_pdf.content_type)
      #debugger
      errors.add(:main_pdf, "Файл должен быть в формате PDF")
    end
  end
end
