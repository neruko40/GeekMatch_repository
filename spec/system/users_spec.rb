require 'rails_helper'

describe 'ユーザー管理機能', type: :system do
    #posts_specと同じようにletでの共通化によってデータを用意しようとしたが、
    #contextで[let(login_user) { new_user}]このようにして、失敗と成功を
    #値を変更して、テストしようとしたが、letが呼び出された時点で、データが作成されて
    #emailが既に存在するというエラーにハマったので、ログインのfill_inを
    #いちいち書くことになった
    describe 'ログイン前' do
        let(:user_a) { create(:new_user, name: 'ユーザー')}

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
        before do
            visit new_user_registration_path
            fill_in 'user[name]', with: 'ユーザー'
            fill_in 'user[email]', with: 'test@test.com'
            fill_in 'user[password]', with: 'password'
            fill_in 'user[password_confirmation]', with: 'password'
            click_button '登録する'
        end
        describe 'プロフィール編集機能' do
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
    end
end