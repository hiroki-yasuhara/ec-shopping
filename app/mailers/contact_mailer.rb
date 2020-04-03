class ContactMailer < ApplicationMailer
    def send_when_admin_reply(user_item) #メソッドに対して引数を設定
    @user_item = user_item #ユーザー情報
    @item = @user_item.item
    @user1 = @item.user
    @user2 = @user_item.user
    
    mail to: @user1.email, subject: '【EC-Shopping】 お客様より、商品の購入がありました'
  end
end
