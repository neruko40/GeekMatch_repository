class LikesController < ApplicationController
    before_action :set_post, only: [:create, :destroy]

    def create
        @like = Like.create(user_id: current_user.id, post_id: params[:post_id])
        if @like.save
            redirect_back(fallback_location: root_path)
        else
            redirect_back(fallback_location: root_path)
        end
    end

    def destroy
        @like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
        if @like.destroy
            redirect_back(fallback_location: root_path)
        else
            redirect_back(fallback_location: root_path)
        end
    end

    private

    def set_post
        @post = Post.find(params[:post_id])
    end

end
