class CommentsController < ApplicationController
 before_action :find_article
 before_action :authenticate_user!


 def create
  @comment = Comment.new(comment_params)
  @comment.article = @article
    @comment.user = current_user if current_user
  if @comment.save
    flash[:notice] = "Your comment is saved"
   redirect_to article_path(@article)
  else
    render 'articles/show'
  end
 end

 def edit
   @comment = Comment.find(params[:id])
   return unless authorize_comment
 end

 def update
    return unless authorize_comment
   @comment = Comment.find(params[:id])
   if @comment.update(comment_params)
     redirect_to article_path(@article)
   else
     render 'edit'
   end
 end

 def destroy
  @comment = Comment.find(params[:id])
  return unless authorize_comment
  @comment.destroy
  redirect_to article_path(@article)
 end

private

def authorize_comment
  if @comment.user != current_user && !current_user&.admin?
    flash[:alert] = "You are not allowed to be here"
    redirect_to article_path
   false
  else
   true
  end
end


 def comment_params
  params.require(:comment).permit(:user, :body)
 end

 def find_article
  @article = Article.find(params[:article_id])
 end
end
