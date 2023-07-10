class Group < ApplicationRecord
  has_many :users

  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups

  validates :name, presence: true
  validates :group_type, presence: true
  validates :code, presence: true
  validates :email, presence: true
  validates :phone, presence: true

  has_one_attached :logo, dependent: :destroy
  validate :acceptable_image

private

  def acceptable_image
    return unless logo.attached?

    unless logo.blob.byte_size <= 1.megabyte
      errors.add(:logo, "Cлишком велик размер файла :-( Допустимо: не более 1 мб")
    end

    acceptable_types = ["application/jpeg", "application/png"]
    unless acceptable_types.include?(logo.content_type)
      errors.add(:logo, "Должен быть PNG или JPG")
    end
  end
end
