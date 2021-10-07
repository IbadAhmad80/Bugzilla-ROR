class SessionsController < ApplicationController


  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      redirect_to user_url(user)
    else
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right
      render 'new'
    end
  end


  def destroy
    log_out
    redirect_to root_url
  end


end
