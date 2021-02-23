FactoryBot.define do
    factory :post do
        kind {'アイデア'}
        title {'テスト投稿'}
        content {'テスト投稿'}
        :user
    end
end
