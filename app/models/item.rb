class Item < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  belongs_to :user
  belongs_to :category
  
  scope :search, -> (search_params) do
    return if search_params.blank?
    
    #name_like(search_params[:name]).cotegory_like(search_params[:cotegory_id])
    name_like(search_params[:name])
  end
  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  #scope :cotegory_like, -> (cotegory_id) { where('cotegory LIKE ?', "%#{cotegory_id}%") if cotegory_id.present? }
  
  has_many :user_items
  has_many :buyers, through: :user_items, source: :user
end
