class User < ApplicationRecord
  enum role: {
               guest: 0,
               user: 1,
               student: 2,
               employee: 3,
               admin: 4,
               super_admin: 5
             }.freeze # , _suffix: :role

  belongs_to :group

  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups

  has_many :categories, dependent: :destroy
  has_many :books, dependent: :destroy

  validates :group_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :middle_name, presence: true
  validates :position, presence: true
  validates :phone, presence: true

  validates :password, length: { in: 6..20 }
  validates :email, exclusion: { in: %w[superadmin@library.kz
                                        admin@library.kz
                                        guest@library.kz],
                                 message: '%{value} has already been taken.' }

  def author_of?(resource)
    resource.user_id == id
  end

  def self.start_import(file, group, user)
    Services::ImportUser.new(file, group, user).import
  end

  def super_admin?
    role == 'super_admin'
  end

  def admin?
    role == 'admin'
  end

  def full_name
    "#{self.first_name} #{self.last_name} #{self.middle_name}"
  end

  # Include default devise modules. Others available are:
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :lockable,
         :timeoutable,
         :trackable,
         :omniauthable
end
