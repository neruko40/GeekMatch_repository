class Post < ApplicationRecord
    validates :kind, presence: true
    validates :title, presence: true
    validates :content, presence: true

    belongs_to :user, optional: true
    has_many :comments, dependent: :destroy

end
