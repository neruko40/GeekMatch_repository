class CommentsController < ApplicationController
  before_action :authenticate_user! 

  def create
    @comment = current_user.comments.new(comment_params)#こっちもcommentのcは小文字
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to request.referer, notice: "投稿を削除しました。"
  end

  private
  def comment_params
  params.require(:comment).permit(:comment_content, :post_id)
  end
end
