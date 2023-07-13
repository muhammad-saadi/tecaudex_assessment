class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password]) && user&.role.include?(params[:session][:role])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Logged in successfully.'
    else
      flash.now[:alert] = 'Invalid email, password, or role.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to signup_url, notice: 'Logged out successfully.'
  end
end