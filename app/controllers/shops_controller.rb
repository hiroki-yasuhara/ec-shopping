class ShopsController < ApplicationController
  before_action :require_user_logged_in
  def index
    session[:category] = nil
    session[:category_id] = nil
    session[:name] = nil
    @items = Item.order(id: :desc).page(params[:page]).per(10)
  end
  
  def search
    session[:name] = params[:search][:name]
    @search_params = user_search_params
    @items =Item.search(@search_params).order(id: :desc).page(params[:page]).per(10)
    render "shops/index"
  end
  
  def category
    session[:name] = nil
    if params[:id] != '999'
      category = Category.find(params[:id])
      session[:category] = category.category
      session[:category_id] = params[:id]
      @items =Item.where(category_id: params[:id]).order(id: :desc).page(params[:page]).per(10)
    else
      session[:category] = nil
      @items = Item.page(params[:page]).per(10)
    end
    render "shops/index"
  end

  def create
    item = Item.find(params[:id])
    current_user.buy(item)
    flush[:success] = '商品の購入を確定しました。振り込み確後、商品を発送します。'
    render "shops/result"
  end
  
  
  def user_search_params
    params.fetch(:search, {}).permit(:name,:category_id )
  end
end
