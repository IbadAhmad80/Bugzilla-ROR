class SessionsController < ApplicationController

  def new
    @user=User.new
    if logged_in?
      redirect_to @current_user
    else
      render 'new'
    end
  end


  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
        if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to user
        else
          message = "Account not activated. "
          message += "Check your email for the activation link."
          flash[:warning] = message
          redirect_to root_url
        end
    else
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right
      render 'new'
    end
  end


  def destroy
    log_out if logged_in?
    redirect_to root_url
  end


end
