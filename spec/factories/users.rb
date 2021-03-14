FactoryBot.define do
    factory :user do
        name {'テストユーザー'}
        email {'test1@example.com'}
        password {'password'}
    end

    # factory :user2 do
    #     name {'テストユーザー2'}
    #     email {'test2example.com'}
    #     password {'password2'}
    # end

    # factory :new_user, class: User do
    #     name {'ユーザー'}
    #     email {'test2@example.com'}
    #     password {'password'}
    #     password_confirmation {'password'}
    # end

    # factory :user3 do
    #     name {'テストユーザー3'}
    #     email {'test3example.com'}
    #     password {'password3'}
    # end
end