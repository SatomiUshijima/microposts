class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :followings, :followers]
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :authenticate!, only: [:edit, :update]

  # つぶやき一案表示
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  # フォローしているユーザ表示
  def followings
    @user = User.find(params[:id])
    @relationships = @user.following_users
  end
    # フォローされているユーザ表示
  def followers
    @user = User.find(params[:id])
    @relationship2 = @user.follower_users
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
  
  # check current_user is editing self ?
  def authenticate!
    if @user != current_user
      redirect_to root_url, flash: { alert: "不正なアクセス" }
    end
  end
  

end
 
