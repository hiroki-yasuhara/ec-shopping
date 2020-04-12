class Item < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  belongs_to :user
  belongs_to :category
  
  validates :name, presence: true, length: { maximum: 30 }
  validates :price,  numericality: { only_integer: true }, length: { maximum: 10 }
  validates :content, presence: true, length: { maximum: 100 }
  validates :stock , numericality: { only_integer: true }, length: { maximum: 3 }
  
  scope :search, -> (search_params) do
    return if search_params.blank?
    name_like(search_params[:name]).category_id(search_params[:category_id])
  end

  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :category_id, -> (category_id) { where(category_id: category_id) if category_id.present? }
  
  has_many :user_items,dependent: :destroy
  has_many :buyers, through: :user_items, source: :user
end
