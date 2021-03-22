class Post < ApplicationRecord
    validates :kind, presence: true
    validates :title, presence: true
    validates :content, presence: true

    belongs_to :user, optional: true
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy

    def like_user(user_id)
        likes.find_by(user_id: user_id)
    end

end
