class SessionsController < ApplicationController
  def create
    puts params.inspect
  	user = User.where(email: params[:session][:email].downcase).first
    if user && user[:password] == params[:session][:password]
    	log_in user
    	redirect_to user_path(user)
    else
	  	flash[:alert] = "Wrong email or password. please try again."
	  	render 'new'
	  end
  end

  def new
  end

  def destroy
  	log_out if logged_in?
    redirect_to root_path
  end
end
