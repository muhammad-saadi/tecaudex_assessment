class User < ApplicationRecord
  has_many :products, dependent: :destroy

  has_one :cart

   validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }

  enum role: { admin: 'admin', vendor: 'vendor', customer: 'customer' }

  def admin?
    role == 'admin'
  end

  def vendor?
    role == 'vendor'
  end

  def customer?
    role == 'customer'
  end
end
