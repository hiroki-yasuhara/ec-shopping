class NotificationMailer < ApplicationMailer
    def send_when_user_reply(user_item) #メソッドに対して引数を設定
    @user_item = user_item #ユーザー情報
    @item = @user_item.item
    @user1 = @item.user
    @user2 = @user_item.user
    
    mail to: @user2.email, subject: '【EC-Shopping】 商品の購入が完了しました。'
  end
end
