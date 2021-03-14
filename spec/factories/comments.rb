FactoryBot.define do
    factory :comment do
        comment_content {'コメント'}
        :user
        :post
    end
end