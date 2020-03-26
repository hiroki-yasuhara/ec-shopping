class ShopsController < ApplicationController
  before_action :require_user_logged_in
  def index
    @items = Item.page(params[:page]).per(25)
  end
  

  def create
  end
end
