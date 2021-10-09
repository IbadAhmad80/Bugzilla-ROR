class BugsController < ApplicationController
  before_action :logged_in_user, only: [:new,:show,:index,:edit]
  before_action :get_all_users, only: [:new,:create,:edit,:update]


  def new
    @bug=Bug.new
  end

  def create
    @bug = current_user.bugs.build(bugs_params)
    if @bug.save
        flash[:success] = "Bug created!"
        redirect_to @bug
    else
        render 'new'
    end
  end

  def show
    if current_user.role=='Manager'
      @bug=Bug.find(params[:id])
    elsif (current_user.role=='QA') && (Bug.find(params[:id])[:user_id]==current_user.id)
      @bug=Bug.find(params[:id])
    else
      flash.now[:success] = "You dosnt have administrative rights"
      redirect_to current_user
    end
  end

  def index
    if current_user.role=='Manager'
      @bugs=Bug.all
    elsif current_user.role=='QA'
      @bugs=Bug.where(user_id:current_user.id)
    end
  end

  def edit
    if current_user.role=='Manager'
      @bug=Bug.find(params[:id])
    elsif (current_user.role=='QA') && ((Bug.find(params[:id])[:user_id])==current_user.id)
      @bug=Bug.find(params[:id])
    else
      flash.now[:success] = "You dosnt have administrative rights"
      redirect_to current_user
    end
  end

  def update
    @bug = Bug.find(params[:id])
    if @bug.update(bugs_params)
      redirect_to @bug
    else
      render 'edit'
    end
  end

  private

  def bugs_params
      params.require(:bug).permit(:title,:description,:estimated_time,:status,:developer_id,:qa_id,:priority)
  end

  def get_all_users
      @developer=get_all_developers
      @QA=get_all_QA
  end


end
