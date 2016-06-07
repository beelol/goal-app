class SessionsController < ApplicationController
  def new
    @user = User.new

    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      login_user!(@user)
      redirect_to users_url
    else
      render :new
    end
  end

  def destroy
    logout_user!
    render :new
  end
end
