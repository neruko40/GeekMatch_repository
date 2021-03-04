require 'rails_helper'

# let(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }


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
                    expect(page).to have_content 'Welcome! You have signed up successfully.'
                end
            end
            context 'メールアドレス未記入' do
                it '登録失敗' do
                    fill_in 'user[name]', with: 'ユーザー'
                    fill_in 'user[email]', with: ''
                    fill_in 'user[password]', with: 'password'
                    fill_in 'user[password_confirmation]', with: 'password'
                    click_button '登録する'
                    expect(page).to have_content 'Email can\'t be blank'
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
                    expect(page).to have_content('Email has already been taken')
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
                    visit edit_user_registration_path
                    fill_in 'user[email]', with: 'testing@test.com'
                    fill_in 'user[current_password]', with: 'password'
                    click_button 'Update'
                    expect(page).to have_content('Your account has been updated successfully.')
                end
            end
            context 'パスワード未入力' do
                it 'ユーザーの編集に失敗' do
                    visit edit_user_registration_path
                    fill_in 'user[email]', with: 'testing@test.com'
                    fill_in 'user[current_password]', with: ''
                    click_button 'Update'
                    expect(page).to have_content('Current password can\'t be blank')
                end
            end
            
        end

    end
    

    
end