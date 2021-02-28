require 'rails_helper'

let(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
let(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com') }

describe 'ユーザー管理機能', type: :system do

    describe 'ログイン前' do
        describe 'ユーザー新規登録' do
            context 'フォーム入力値が正常' do
                
            end
            context 'メールアドレス未記入' do
                
            end
            context '登録済みメールアドレス' do
                
            end
        end

        
    end

    describe 'ログイン後' do
        describe 'プロフィール編集機能' do
            
        end

    end
    

    
end