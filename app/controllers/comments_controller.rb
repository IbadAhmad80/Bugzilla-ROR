class CommentsController < ApplicationController

    def new  
      @comment=Comment.new
      # @bug=Bug.find(params[:bug_id])
      # debugger
    end

    def create
     bug=Bug.find('2')
     @comment = bug.comments.build(comment_params)
      if @comment.save
        flash[:success] = "Comment Created."
        redirect_to bugs_path
      else
        render 'new'
      end   
    end

    private

    def comment_params
      params.require(:comment).permit(:title, :content)
    end
    
end
