require 'rails_helper'

describe '投稿管理機能', type: :system do
    let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
    let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
    let!(:post_a) { FactoryBot.create(:post, title: '最初の投稿', user: user_a) }

    before do
        visit sign_in_path
        fill_in 'user[name]', with: login_user.name
        fill_in 'user[password]', with: login_user.password
        click_button 'ログインする'
        visit posts_path
    end
    describe '一覧表示機能' do
        context 'ユーザーAがログインしている時' do
            let(:login_user) { user_a }
            it 'ユーザーAが作成したタスクに編集が表示される' do
                expect(page).to have_content '編集'
            end
        end

        context 'ユーザーBがログインしている時' do
            let(:login_user) { user_b }

            it 'ユーザーAが作成した投稿に編集が表示されない' do
                expect(page).to have_no_content '編集'
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

    describe '新規作成機能' do
        let(:login_user) { user_a }

        before do
            visit new_post_path
            fill_in 'post[title]', with: post_title
            fill_in 'post[content]', with: post_content
            click_button '投稿'
        end

        context '新規作成画面でタイトルを入力した場合' do
            let(:post_title) { 'テスト用タイトル' }
            let(:post_content) { 'テスト用内容' }

            it '正常に登録される' do
                expect(page).to have_content('テスト用タイトル')
            end
        end

        context '新規作成画面でタイトルを入力しなかった場合' do
            let(:post_title) { '' }
            let(:post_content) { 'テスト用内容' }
        

            it 'エラーとなる' do
                expect(page).to have_content('投稿に失敗しました…')
            end
        end
    end
end