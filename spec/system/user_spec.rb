require 'rails_helper'
RSpec.describe 'ユーザー登録機能', type: :system do
  describe 'ユーザー新規登録' do
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
    context 'ログインせずにタスク一覧に移動した場合' do
      it 'ログイン画面に移動する' do
        visit tasks_path
        expect(page).to have_content 'ログイン'
      end
    end
  end

  describe 'セッション機能' do
    before do
      user = FactoryBot.create(:user)
      visit new_session_path
      fill_in 'メールアドレス', with: 'test@test.com'
      fill_in 'パスワード', with: 'test@test.com'
      find('#log_in').click
    end
    context 'ユーザーがログインした場合' do
      it 'ログイン状態になる' do
        expect(page).to have_content 'テストユーザー'
      end
    end
    context 'ユーザーがログインしている場合' do
      it 'マイページに飛べる' do
        click_on "マイページ"
        expect(page).to have_content 'テストユーザー'
      end
    end
    context 'ログイン中に他人のマイページに飛んだ場合' do
      it 'タスク一覧に遷移する' do
        second_user = FactoryBot.create(:second_user)
        visit user_path(second_user.id)
        expect(page).to have_content 'タスク一覧'
      end
    end
    context 'ログアウトした場合' do
      it 'ログアウト状態になる' do
        click_on 'ログアウト'
        expect(page).to have_content 'ログイン'
      end
    end
  end

end
