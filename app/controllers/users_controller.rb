class UsersController < ApplicationController

  def new
    @user=User.new
  end

  def create
    @user = User.new(user_params)
    # debugger
    if @user.save
      @user.send_activation_email
      log_in @user
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  # Returns the hash digest of the given string.
  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # Returns a random token.
  def new_token
    SecureRandom.urlsafe_base64
  end


  private
    def user_params
      params.require(:user).permit(:name, :email, :role, :password, :password_confirmation)
    end

end
