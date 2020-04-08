class ItemsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy,:edit]
  
  def index
    @items = current_user.items.order(id: :desc).page(params[:page])
  end

  def show
    @item=Item.find(params[:id])
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
      flash.now[:danger] = '商品の登録に失敗しました。'
        render :new
    end
  end

  def edit
    @item=Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(items_params)
      flash[:success] = '商品情報は正常に更新されました'
      redirect_to @item
    else
      flash.now[:danger] = '商品情報は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @item.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_to items_path
  end
  
  private
  
  def items_params
    params.require(:item).permit(:name,:price,:category_id,:content,:image)
  end  
  

  def correct_user
    @item = current_user.items.find_by(id: params[:id])
    unless @item
    redirect_to items_path
    end
  end
end
