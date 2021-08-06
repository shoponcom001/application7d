class CommentsController < ApplicationController

  def create
    @book = Book.find(params[:id])
    @comment = @book.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :book_id, :user_id)
  end

end
