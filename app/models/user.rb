class User < ActiveRecord::Base
  has_secure_password

  has_many :comments
  has_many :orders

  before_save { email.downcase! }

  validates :name, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false },
                    presence: true
  validates :phone, presence: true,
                    length: { minimum: 5},
                    uniqueness: true
  validates :role, presence: true
  validates :password, presence: true,
                       length: { minimum: 6 },
                       if: :password
  validates :address, presence: true

  enum role: [:admin, :user, :manager, :staff]

  self.per_page = 50

  def to_param
    "#{id} #{name}".parameterize
  end

end
