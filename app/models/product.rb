class Product < ApplicationRecord
  belongs_to :vendor, class_name: 'User', foreign_key: 'user_id'

  has_and_belongs_to_many :categories
end
