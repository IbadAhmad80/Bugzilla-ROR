class CommentsController < ApplicationController
  before_action :developer_check
  before_action :logged_in_user, only: [:new,]

    def new  
      @comment=Comment.new
      session[:bug_id]=params[:bug_id]
    end

    def create
     bug=Bug.find(session[:bug_id])
     @comment = bug.comments.build(comment_params)
      if @comment.save
        flash[:success] = "Comment Created."
        redirect_to bug
      else
        render 'new'
      end   
    end

    private

    def comment_params
      params.require(:comment).permit(:title, :content)
    end

    def developer_check
      if current_user.role!='Developer'
        redirect_to bugs_path
      end
    end
    
end
