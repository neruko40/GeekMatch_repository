class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  # def user
  #   return User.find_by(id: self.user_id)
  # end

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    # @user = User.find_by(id: @post.user_id)
  end

  def new
    @post = Post.new
    @user = User.new
  end

  def create
    post = Post.new(
      post_params
      )
    post.save!
    redirect_to root_path, notice: "投稿しました。"
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def post_params
      params.require(:post).permit(:kind, :title, :content, :user_id)
    end
  
end
