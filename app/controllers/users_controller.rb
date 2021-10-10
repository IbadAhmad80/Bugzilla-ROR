class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show,:index,:edit]
  before_action :admin_check, only: [:edit,:index]

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

  def index
      @users=User.where(role:'QA').or(User.where(role:'Developer'))
  end

  def edit 
      @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attribute(:role,user_params[:role])
      redirect_to @user
    else
      render 'edit'
    end
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

    def admin_check
      if current_user.role!='Manager'
        redirect_to current_user
      end
    end

end
