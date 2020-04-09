class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'アカウントを登録しました。'
      redirect_to login_path
    else
      flash.now[:danger] = 'アカウントの登録に失敗しました。'
      render :new
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :bank, :account_number,:password, :password_confirmation)
  end
end
