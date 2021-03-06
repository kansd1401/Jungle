class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    #downcases and trims the email before adding to database
    @user.email.strip!
    @user.email.downcase!
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      render :new
    end
  end   

  private
  def user_params
    params.require(:user).permit(:name, :last_name, :email, :password, :password_confirmation)
  end
end
