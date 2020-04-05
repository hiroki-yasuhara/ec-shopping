class UserItem < ApplicationRecord
  belongs_to :user
  belongs_to :item
  validates :quantity , numericality: { only_integer: true }
end
