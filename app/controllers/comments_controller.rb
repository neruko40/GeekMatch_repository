class CommentsController < ApplicationController
  before_action :authenticate_user! 

  def create
    @comment = current_user.comments.new(comment_params)#こっちもcommentのcは小文字
    if @comment.save
      redirect_back(fallback_location: root_path, notice: 'コメントを投稿しました。')
    else
      redirect_back(fallback_location: root_path, notice: 'コメントの投稿に失敗しました。')
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to request.referer, notice: "コメントを削除しました。"
    else
      redirect_to request.referer, notice: "コメントの削除に失敗しました。"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment_content, :post_id)
  end
end
