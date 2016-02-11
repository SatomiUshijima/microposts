class UsersController < ApplicationController
   before_action :set_user, only: [:edit, :update]

  def show 
   @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
       redirect_to @user 
    else
      render 'new'
    end
  end

  # 基本情報の編集
  def edit
  end
  
  # 更新処理
  def update
    if @user.update(user_params)
      flash[:seccess] = "Successfully updated"
    # 保存に成功した場合はプロフィールへリダイレクト
      redirect_to @user
    else
      flash[:alert] = "Updating Failed"
      render 'edit'
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                :password_confirmation, :location, :profile)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
 
