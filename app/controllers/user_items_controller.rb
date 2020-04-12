class UserItemsController < ApplicationController
  before_action :require_user_logged_in
    def create
      @item = Item.find(params[:item_id])
      @user_item = current_user.shop(@item)
      @user_item.quantity = params[:user_item][:quantity]
        if @user_item.quantity.nil? || @item.stock >= @user_item.quantity
          if @user_item.save
            @item.decrement(:stock, @user_item.quantity)
            @item.save
            flash[:success] = '商品の購入を確定しました。振り込み確認後、商品を発送します。'
            ContactMailer.send_when_admin_reply(@user_item).deliver
            NotificationMailer.send_when_user_reply(@user_item).deliver
            redirect_to @user_item
          else
            flash.now[:danger] = '商品の購入に失敗しました。'
            @items =Item.name_like(session[:name]).category_id(session[:category_id]).page(params[:page]).per(25)
            render 'shops/index'
          end
        else
          flash.now[:danger] = '在庫数が不足しています。'
          @items =Item.name_like(session[:name]).category_id(session[:category_id]).page(params[:page]).per(25)
          render 'shops/index'
        end
    end
    
    def show
        @user_item = UserItem.find(params[:id])
        @item = @user_item.item
        @user = @item.user
        #@buyer = @user_item.user
    end
    
    def index
        @user_items1 = current_user.user_items
        @user_items2 = current_user.user_items.page(params[:page]).per(25)
    end
    
    private 
    def user_item_params
      params.require(:user_item).permit(:user_id,:item_id) 
    end
end
