class Item < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  belongs_to :user
  belongs_to :category
  
  scope :search, -> (search_params) do
    return if search_params.blank?
    name_like(search_params[:name]).category_id(search_params[:category_id])
  end
  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :category_id, -> (category_id) { where(category_id: category_id) if category_id.present? }
  
  has_many :user_items
  has_many :buyers, through: :user_items, source: :user
end
