class User < ActiveRecord::Base
  has_secure_password

  before_save { email.downcase! }

  validates :name, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false },
                    presence: true
  validates :phone, presence: true
  validates :role, presence: true
  validates :password, presence: true,
                       length: { minimum: 6 }
  validates :address, presence: true

  enum role: [:admin, :user]

  def to_param
    "#{id} #{name}".parameterize
  end

end
