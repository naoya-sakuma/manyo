require 'rails_helper'
RSpec.describe 'ユーザー登録機能', type: :system do
  describe 'ユーザー新規登録機能' do
    context 'ユーザーが新規登録された場合' do
      it 'ユーザーが登録される' do
        visit new_user_path
        fill_in '名前', with: 'テスト'
        fill_in 'メールアドレス', with: 'test@test.com'
        fill_in 'パスワード', with: 'test@test.com'
        fill_in '確認用パスワード', with: 'test@test.com'
        click_on 'Create my account'
        
      end
    end
  end

    describe 'ユーザー新規登録機能' do
      context 'ログインせずにタスク一覧に移動した場合' do
        it 'ログイン画面に移動する' do
        end
      end
    end
  end
