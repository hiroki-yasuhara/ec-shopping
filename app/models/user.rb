class User < ApplicationRecord
    validates :name,  presence: true, length: { maximum:50 }
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                      uniqueness: { case_sensitive: false }
    validates :bank,  presence: true, length: { maximum:20 }
    
    has_secure_password
    
    has_many :items
    has_many :user_items
    has_many :buys, through: :user_items, source: :item
    
    
    def shop(shop_item)
     self.user_items.create(item_id: shop_item.id)

    end
end
