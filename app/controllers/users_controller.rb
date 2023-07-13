class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role = params[:user][:role][1]
    if @user.save
      if @user.admin?
      render 'new', notice: 'User created successfully.'
      elsif @user.vendor?
        redirect_to vendor_products_path
      elsif @user.customer?
      else
      end
        
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :role)
  end
end