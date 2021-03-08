class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def index 
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  private
    def post_params
      params.require(:post).permit(:user_id)
    end
end
