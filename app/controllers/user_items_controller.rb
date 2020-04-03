class UserItemsController < ApplicationController

    def create
        
      item = Item.find(params[:item_id])
      @user_item = current_user.shop(item)
      @user_item.quantity = params[:user_item][:quantity]

        @user_item.save
          flash[:success] = '商品の購入を確定しました。振り込み確認後、商品を発送します。'
          ContactMailer.send_when_admin_reply(@user_item).deliver
          redirect_to @user_item
       # else
       #   flash.now[:danger] = 'ユーザの登録に失敗しました。'
       #   render root_url
       # end
    end
    
    def show
        @user_item = UserItem.find(params[:id])
        @item = @user_item.item
        @user = @item.user
        @buyer = @user_item.user
    end
    
    def index
        @user_items = current_user.user_items.page(params[:page]).per(25)
    end
    
    private 
    def user_item_params
      params.require(:user_item).permit(:user_id,:item_id) 
      #params.require(:user_item).permit(:user_id,:item_id,:quantity) 
    end
end
