class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :delete]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments #投稿詳細に関連付けてあるコメントを取得
    @comment = current_user.comments.new #投稿詳細画面でコメントの投稿を行うので、formのパラメータ用にCommentオブジェクトを取得
                                         #Comments.newではエラー
  end

  def new
    @post = Post.new
    @user = User.new
  end

  def create
    post = Post.new(post_params)
    if post.save
      redirect_to posts_path, notice: "投稿しました。"
    else
      redirect_to new_post_path, notice: "投稿に失敗しました…"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      redirect_to post_url, notice: "投稿を更新しました。"
    else
      redirect_to post_url, notice: "編集に失敗しました。"
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path, notice: "投稿を削除しました。"
  end

  private

    def post_params
      params.require(:post).permit(:kind, :title, :content)
    end
  
end
