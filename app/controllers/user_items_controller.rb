class UserItemsController < ApplicationController
    
    def create
    end
    
    def show
        @user_item = UserItem.find(params[:id])
        @item = @user_item.item
        @user = @item.user
        @buyer = @user_item.user
    end
    
    def index
    end
end
