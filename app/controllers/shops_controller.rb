class ShopsController < ApplicationController
  before_action :require_user_logged_in
  def index
   # @items = Item.page(params[:page]).per(25)
   
    @search_params = user_search_params
    @items =Item.search(@search_params).page(params[:page]).per(25)
  end
  
  def category
    @items =Item.where(category_id: params[:id]).page(params[:page]).per(25)
    render "shops/index"
  end

  def create
    item = Item.find(params[:id])
    current_user.buy(item)
    flush[:success] = '商品の購入を確定しました。振り込み確後、商品を発送します。'
    render "shops/result"
  end
  
  
  def user_search_params
    params.fetch(:search, {}).permit(:name ,:cotegory_id)
  end
end
