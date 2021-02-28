require 'rails_helper'

describe '投稿管理機能', type: :system do
    let(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
    let(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com') }
    let!(:post_a) { create(:post, title: '最初の投稿', user: user_a) }

    before do
        visit sign_in_path
        fill_in 'user[name]', with: login_user.name
        fill_in 'user[password]', with: login_user.password
        click_button 'ログインする'
        visit posts_path
    end

    describe '新規作成機能' do
        let(:login_user) { user_a }
        before do
            visit new_post_path
            fill_in 'post[title]', with: post_title
            fill_in 'post[content]', with: post_content
            click_button '投稿'
        end
        context '新規作成画面で成功する場合' do
            let(:post_title) { 'テスト用タイトル' }
            let(:post_content) { 'テスト用内容' }
            it '正常に登録される' do
                expect(page).to have_content('テスト用タイトル')
            end
        end
        context '新規作成画面で失敗する場合' do
            let(:post_title) { '' }
            let(:post_content) { 'テスト用内容' }
            it 'エラーとなる' do
                expect(page).to have_content('投稿に失敗しました…')
            end
        end
    end

    describe '一覧表示機能' do
        context 'ユーザーAがログインしている時' do
            let(:login_user) { user_a }
            it '作成した投稿が表示される' do
                expect(page).to have_content '最初の投稿'
            end
        end
    end

    describe '詳細表示機能' do
        context 'ユーザーAがログインしている時' do
            let(:login_user) { user_a }
            before do
                visit post_path( post_a )
            end
            it 'ユーザーAが作成した投稿が表示される' do
                expect(page).to have_content '最初の投稿'
            end
        end
    end

    

    describe '投稿編集機能' do
        context 'ユーザーAがログインしている場合' do
            let(:login_user) { user_a }
            before do
                visit post_path( post_a )
            end
            it '編集が表示される' do
                expect(page).to have_content('編集')
            end
        end
        context 'タイトルを未入力' do
            let(:login_user) { user_a }
            before do
                visit edit_post_path( post_a )
                fill_in 'Title', with: ''
                click_button '更新する'
            end
            it '投稿の編集が失敗する' do
                expect(page).to have_content('編集に失敗しました。')
            end
        end
        context 'タイトルを入力' do
            let(:login_user) { user_a }
            before do
                visit edit_post_path( post_a )
                fill_in 'Title', with: '成功'
                click_button '更新する'
            end
            it '投稿の編集が成功する' do
                expect(page).to have_content('投稿を更新しました。')
            end
        end
        
        context 'ユーザーBがログインしている場合' do
            let(:login_user) { user_b }
            it '編集が表示されない' do
                expect(page).to have_no_content('編集')
            end
        end
    end

    describe '投稿削除機能' do
        context '編集画面に遷移した場合' do
            let(:login_user) { user_a }
            before do
                visit post_path( post_a )
            end
            it '削除が表示される' do
                visit edit_post_path( post_a )
                expect(page).to have_content('削除')
            end
            it '投稿の削除が行える' do
                post_a.destroy
                expect(Post.count).to eq(0)
                # expect( post_a.destroy ).to change( Post, :count ).by(-1)
            end
        end
    end

end

