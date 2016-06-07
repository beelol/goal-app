class UsersController < ApplicationController
  def index
    render :index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login_user!(@user)
      redirect_to users_url
    else

      render :new
    end
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
