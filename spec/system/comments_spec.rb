require 'rails_helper'

describe 'コメント管理機能', type: :system do
    let!(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com', password: 'password') }
    let(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com') }
    let!(:post_a) { create(:post, title: '最初の投稿', user: user_a) }
    let!(:comment_a) { create(:comment, comment_content: 'テストコメント', user: user_a, post: post_a) }

    before do
        visit sign_in_path
        fill_in 'user[name]', with: login_user.name
        fill_in 'user[password]', with: login_user.password
        click_button 'ログインする'
        visit posts_path
    end  
    describe 'コメント新規作成機能' do
        let(:login_user) {user_a}
        context 'コメント投稿成功' do
            it 'コメントフォームを埋める' do
                visit post_path( post_a )
                fill_in 'comment[comment_content]', with: 'テストコメント'
                click_button 'コメントを投稿する'
                expect(page).to have_content('テストコメント')
            end
        end
        context 'コメント投稿失敗' do
            it 'コメントフォームを空でボタンを押下' do
                visit post_path( post_a )
                fill_in 'comment[comment_content]', with: ''
                click_button 'コメントを投稿する'
                expect(page).to have_content('コメントの投稿に失敗しました。')
            end
        end
    end
    describe 'コメント削除機能' do
        context 'ユーザーAでログインした場合' do
            let(:login_user) { user_a }
            it '削除リンクが表示される' do
                visit post_path( post_a )
                expect(page).to have_content('削除')
            end
            it '投稿を削除する際、ポップアップのはいを選択' do
                visit post_path( post_a )
                page.accept_confirm do
                    click_link '削除'
                end
                expect(page).to have_content('コメントを削除しました。')
            end
            it '投稿を削除する際、ポップアップのいいえを選択' do
                visit post_path( post_a )
                page.dismiss_confirm do
                    click_link '削除'
                end
                expect(page).to have_content('テストコメント')
            end
        end
        context 'ユーザーBでログインした場合' do
            let(:login_user) { user_b }
            it '削除が表示されない' do
                visit post_path( post_a )
                expect(page).to have_no_content('削除')
            end
        end
    end
end