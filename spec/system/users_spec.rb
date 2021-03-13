require 'rails_helper'

describe 'ユーザー管理機能', type: :system do
    let(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
    let!(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com') }
    describe 'ログイン前' do
        before do
            visit new_user_registration_path
        end
        describe 'ユーザー新規登録' do
            context 'フォーム入力値が正常' do
                it 'ユーザーの新規登録が成功する' do
                    fill_in 'user[name]', with: 'ユーザー'
                    fill_in 'user[email]', with: 'test@test.com'
                    fill_in 'user[password]', with: 'password'
                    fill_in 'user[password_confirmation]', with: 'password'
                    click_button '登録する'
                    expect(page).to have_content('アカウント登録が完了しました。')
                    expect(page).to have_content('ユーザー編集画面')
                end
            end
            context 'ユーザーネーム未入力' do
                it '登録失敗' do
                    fill_in 'user[name]', with: ''
                    fill_in 'user[email]', with: 'aaa@aaa.com'
                    fill_in 'user[password]', with: 'password'
                    fill_in 'user[password_confirmation]', with: 'password'
                    click_button '登録する'
                    expect(page).to have_content('ユーザーネーム が空白です。')
                    expect(page).to have_content('ユーザーネーム が短過ぎます。')
                end
            end
            context 'ユーザーネームが２文字以下' do
                it '登録失敗' do
                    fill_in 'user[name]', with: 'aa'
                    fill_in 'user[email]', with: 'aaa@aaa.com'
                    fill_in 'user[password]', with: 'password'
                    fill_in 'user[password_confirmation]', with: 'password'
                    click_button '登録する'
                    expect(page).to have_content('ユーザーネーム が短過ぎます。')
                end
            end
            context 'ユーザーネームが21文字以上' do
                it '登録失敗' do
                    fill_in 'user[name]', with: 'アイウエオかきくけこさしすせそたちつてとな'
                    fill_in 'user[email]', with: 'aaa@aaa.com'
                    fill_in 'user[password]', with: 'password'
                    fill_in 'user[password_confirmation]', with: 'password'
                    click_button '登録する'
                    expect(page).to have_content('ユーザーネーム が長過ぎます。')
                end
            end
            context 'メールアドレスが未入力' do
                it '登録失敗' do
                    fill_in 'user[name]', with: 'aaa'
                    fill_in 'user[email]', with: ''
                    fill_in 'user[password]', with: 'password'
                    fill_in 'user[password_confirmation]', with: 'password'
                    click_button '登録する'
                    expect(page).to have_content('メールアドレス が空白です。')
                end
            end
            context '登録済みメールアドレス' do
                let(:login_user) { user_a }
                before do
                    fill_in 'user[name]', with: login_user.name
                    fill_in 'user[email]', with: login_user.email
                    fill_in 'user[password]', with: login_user.password
                    fill_in 'user[password_confirmation]', with: login_user.password_confirmation
                    click_button '登録する'
                end
                it '登録失敗' do
                    expect(page).to have_content('メールアドレス は、すでに使用されています。')
                end
            end
            context 'パスワードが未入力' do
                it '' do
                    fill_in 'user[name]', with: 'aaa'
                    fill_in 'user[email]', with: 'aaa@aaa.com'
                    fill_in 'user[password]', with: ''
                    fill_in 'user[password_confirmation]', with: 'password'
                    click_button '登録する'
                    expect(page).to have_content('パスワード が空白です。')
                    expect(page).to have_content('パスワード（確認用） が空白です。')
                end
            end
            context 'パスワード５文字以下' do
                it '登録失敗' do
                    fill_in 'user[name]', with: 'aaa'
                    fill_in 'user[email]', with: 'aaa@aaa.com'
                    fill_in 'user[password]', with: 'ppppp'
                    fill_in 'user[password_confirmation]', with: 'password'
                    click_button '登録する'
                    expect(page).to have_content('パスワード が短過ぎます。')
                end
            end
            context '確認用パスワードが未入力' do
                it '' do
                    fill_in 'user[name]', with: 'aa'
                    fill_in 'user[email]', with: 'aaa@aaa.com'
                    fill_in 'user[password]', with: 'password'
                    fill_in 'user[password_confirmation]', with: ''
                    click_button '登録する'
                    expect(page).to have_content('パスワード（確認用） が空白です。')
                end
            end
        end
    end

    describe 'ログイン後' do
        describe 'プロフィール編集機能' do
            before do
                visit new_user_registration_path
                fill_in 'user[name]', with: 'ユーザー'
                fill_in 'user[email]', with: 'test@test.com'
                fill_in 'user[password]', with: 'password'
                fill_in 'user[password_confirmation]', with: 'password'
                click_button '登録する'
            end
            context 'フォームの入力値が正常' do
                it 'ユーザーの編集に成功' do
                    fill_in 'user[email]', with: 'testing@test.com'
                    fill_in 'user[current_password]', with: 'password'
                    click_button '更新する'
                    expect(page).to have_content('アカウント情報を変更しました。')
                    expect(page).to have_content('ユーザーさんの詳細ページ')
                end
            end
            context '現在のパスワード未入力' do
                it 'ユーザーの編集に失敗' do
                    fill_in 'user[email]', with: 'testing@test.com'
                    fill_in 'user[current_password]', with: ''
                    click_button '更新する'
                    expect(page).to have_content('現在のパスワード が空になっています')
                end
            end
            context '変更後のパスワードが未入力' do
                it 'ユーザーの編集に失敗' do
                    fill_in 'user[password]', with: ''
                    fill_in 'user[password_confirmation]', with: 'password'
                    fill_in 'user[current_password]', with: 'password'
                    click_button '更新する'
                    expect(page).to have_content('パスワード が空白です。')
                    expect(page).to have_content('パスワード（確認用） が空白です。')
                end
            end
            context '確認用パスワードが未入力' do
                it 'ユーザーの編集に失敗' do
                    fill_in 'user[password]', with: 'password'
                    fill_in 'user[password_confirmation]', with: ''
                    fill_in 'user[current_password]', with: 'password'
                    click_button '更新する'
                    expect(page).to have_content('パスワード（確認用） が空白です。')
                end
            end
        end
        describe 'ユーザー削除機能' do
            before do
                visit new_user_registration_path
                fill_in 'user[name]', with: 'ユーザー'
                fill_in 'user[email]', with: 'test@test.com'
                fill_in 'user[password]', with: 'password'
                fill_in 'user[password_confirmation]', with: 'password'
                click_button '登録する'
            end
            context 'ユーザー削除' do
                it 'ポップアップをYesと回答' do
                    page.accept_confirm do
                        click_button 'アカウントを削除'
                    end
                    expect(page).to have_content('アカウントを削除しました。またのご利用をお待ちしております。')
                end
                it '' do
                    page.dismiss_confirm do
                        click_on 'アカウントを削除'
                    end
                    expect(page).to have_content('ユーザー編集画面')
                end
            end
        end
        describe 'ユーザー詳細表示機能' do            
            context '編集へのリンク' do
                let(:login_user) { user_a }
                before do
                    visit sign_in_path
                    fill_in 'user[name]', with: login_user.name
                    fill_in 'user[password]', with: login_user.password
                    click_button 'ログインする'
                end
                it '非表示' do
                    visit users_show_path(id: user_b.id)
                    expect(page).to have_no_content('ユーザー情報編集画面へ')
                end
                it '表示' do
                    visit users_show_path(id: user_a.id)
                    expect(page).to have_content('ユーザー情報編集画面へ')
                end
            end
        end
        describe 'ユーザー一覧表示機能' do
            context 'ユーザー一覧ページに遷移' do
                let(:login_user) { user_a }
                before do
                    visit sign_in_path
                    fill_in 'user[name]', with: login_user.name
                    fill_in 'user[password]', with: login_user.password
                    click_button 'ログインする'
                    visit users_index_path
                end
                it 'a、b２つのユーザーを表示' do
                    expect(page).to have_content('ユーザーA')
                    expect(page).to have_content('ユーザーB')
                end
            end
        end
    end 
end