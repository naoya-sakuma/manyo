require 'rails_helper'
RSpec.describe 'セッション機能', type: :system do
  describe 'ユーザーログイン機能' do
    context 'ユーザーがログインした場合' do
      it 'ログイン状態になる' do
        a = FactoryBot.create(:session)
        visiti new_session_path
        fill_in 'Email', with: 'test@test.com'
        fill_in 'Password', with: 'test@test.com'
      end
    end
  end
  describe 'ユーザー新規登録機能' do
    context 'ログインしている場合' do
      it 'マイページに遷移できる' do
      end
    end
  end

  describe 'ユーザー新規登録機能' do
    context '他ユーザーの詳細画面にアクセスした場合' do
      it 'タスク一覧ページに遷移する' do
      end
    end
  end

  describe 'ユーザー新規登録機能' do
    context 'ログインしている場合' do
      it 'ログアウトできる' do
      end
    end
  end
end
