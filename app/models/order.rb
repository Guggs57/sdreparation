class Order < ApplicationRecord
  validates :name, :email, :phone, :address, :items, presence: true
end
