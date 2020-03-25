class ItemsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @items = current_user.items.order(id: :desc).page(params[:page])
  end

  def show
  end

  def new
    @item = current_user.items.build
  end

  def create
    @item =current_user.items.build(items_params)
    if @item.save
      flash[:success] = '商品を登録しました。'
      redirect_to items_path
    else
      @items = current_user.items.order(id: :desc).page(params[:page])
      flash.now[:danger] = '商品の登録に失敗しました。'
      render 'items/index'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private
  
  def items_params
    params.require(:item).permit(:name,:price,:category_id,:content,:image)
  end  
end
