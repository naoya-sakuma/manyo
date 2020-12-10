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
      @user = FactoryBot.create(:user)
      @second_user = FactoryBot.create(:second_user)
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
        visit user_path(@second_user.id)
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

  describe '管理画面' do
    before do
      @user = FactoryBot.create(:user)
      @second_user = FactoryBot.create(:second_user)
      visit new_session_path
      fill_in 'メールアドレス', with: 'test@test.com'
      fill_in 'パスワード', with: 'test@test.com'
      find('#log_in').click
    end
    context '管理ユーザーがログインしている場合' do
      it '管理画面にアクセスできる' do
        click_on 'ユーザー管理画面'
        expect(page).to have_content 'ユーザー管理画面'
      end
    end
    context '一般ユーザーがログインしている場合' do
      it '管理画面にアクセスできない' do
        click_on 'ログアウト'
        fill_in 'メールアドレス', with: 'test2@test.com'
        fill_in 'パスワード', with: 'test2@test.com'
        find('#log_in').click
        visit admin_users_path
        expect(page).not_to have_content 'ユーザー管理画面'
      end
    end
    context '管理ユーザーがログインしている場合' do
      it '他ユーザーの詳細画面にアクセスできる' do
        visit admin_user_path(@second_user.id)
      end
    end
    context '管理ユーザーがログインしている場合' do
      it '一般ユーザーを編集できる' do
        visit edit_admin_user_path(@second_user.id)
        fill_in '名前', with: '編集後テストユーザー2'
        fill_in 'メールアドレス', with: 'edited_test2@test.com'
        fill_in 'パスワード', with: 'edited_test2@test.com'
        fill_in '確認用パスワード', with: 'edited_test2@test.com'
        fill_in '管理者権限', with: 'false'
        click_on 'ユーザー編集'
        expect(page).not_to have_content '\n編集後テストユーザー2のページ'
      end
    end
    context '管理ユーザーがログインしている場合' do
      it 'ユーザーを削除できる' do
        visit edit_admin_user_path(@user.id)
        fill_in '名前', with: '管理者ユーザー'
        fill_in 'メールアドレス', with: 'admin_test@test.com'
        fill_in 'パスワード', with: 'admin_test@test.com'
        fill_in '確認用パスワード', with: 'admin_test@test.com'
        fill_in '管理者権限', with: 'true'
        click_on 'ユーザー編集'
        click_on 'ユーザー管理画面'
        click_on '削除', match: :first
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content 'テストユーザー2'
      end
    end
  end
end
