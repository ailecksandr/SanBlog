class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    redirect_to post_path(@post)
  end

  def show
  end

  def index
    @post = Post.find(params[:post_id])
    @comments = Comment.where(post_id: params[:post_id])
    @author = (user_signed_in?)? current_user.email : 'Анонімний користувач'
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy!

    redirect_to :back
  end

  private
  def comment_params
    params.require(:comment).permit(:post_id, :author, :body)
  end
end
