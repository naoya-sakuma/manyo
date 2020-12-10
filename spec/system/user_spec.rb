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
        expect(page).to have_content 'test'
        expect(page).to have_content 'test@test.com'
      end
    end
  end

  describe 'ユーザー新規登録機能' do
    context 'ログインせずにタスク一覧に移動した場合' do
      it 'ログイン画面に移動する' do
        visit tasks_path
        expect(page).to have_content 'Log in'
      end
    end
  end

  describe 'ユーザーログイン機能' do
    context 'ユーザーがログインした場合' do
      it 'ログイン状態になる' do
        user = FactoryBot.create(:user)
        visiti new_session_path
        fill_in 'Email', with: 'test@test.com'
        fill_in 'Password', with: 'test@test.com'
      end
    end
  end
end
