require 'rails_helper'

describe '機能間テスト', type: :system do
    let(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
    let!(:post_a) { create(:post, title: '最初の投稿', user: user_a) }
    let!(:comment_a) { create(:comment, comment_content: 'テストコメント', user: user_a, post: post_a) }

    describe 'dependentのテスト' do
        before do
            visit sign_in_path
            fill_in 'user[name]', with: login_user.name
            fill_in 'user[password]', with: login_user.password
            click_button 'ログインする'
        end
        context 'ユーザーAを削除した場合' do
            let(:login_user) { user_a }
            it '投稿も削除される' do
                expect{user_a.destroy}.to change{Post.count}.by(-1)
            end
        end
        context 'ユーザーAを削除した場合' do
            let(:login_user) { user_a }
            it 'コメントも削除される' do
                expect{user_a.destroy}.to change{Comment.count}.by(-1)
            end
        end
    end
end