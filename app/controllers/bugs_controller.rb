class BugsController < ApplicationController
  before_action :logged_in_user, only: [:new,:show,:index,:edit]
  before_action :get_all_users, only: [:new,:create,:edit,:update]
  before_action :administrative_access, only: [:show]


  def new
    if current_user.role!='Developer'
      @bug=Bug.new
    else
      flash[:danger] = "Only Manager and QA have rights to create the bug"
      redirect_to current_user
    end
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
    administrative_access
  end

  def index
    if current_user.role=='Manager'
      @bugs=Bug.all
    elsif current_user.role=='QA'
      @bugs=Bug.where(user_id:current_user.id)
    else
      @bugs=Bug.where(developer_id:current_user.id)
    end 
  end

  def edit
    administrative_access
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

  def administrative_access
    if current_user.role=='Manager'
      @bug=Bug.find(params[:id])
    elsif (current_user.role=='QA') && ((Bug.find(params[:id])[:user_id])==current_user.id)
      @bug=Bug.find(params[:id])
    elsif (current_user.role=='Developer') && ((Bug.find(params[:id])[:developer_id])==current_user.id)
      @bug=Bug.find(params[:id])
    else
      flash[:danger] = "Only Manager has rights to see all bugs"
      redirect_to current_user
    end

    
  end


end
