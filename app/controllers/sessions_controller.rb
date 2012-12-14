class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by_username(params[:session][:username].downcase)
    
    if user && user.authenticate(params[:session][:password])
      login user
      redirect_to user
    else
      flash.now[:error] = 'Invalid username/password combination'
      render 'new'
    end
    
  end
  
  def destroy
    logout
    redirect_to login_path
  end
  
end
