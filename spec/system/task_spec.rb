require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    before do
      user = FactoryBot.create(:user)
      label = FactoryBot.create(:label)
      visit new_session_path
      fill_in 'メールアドレス', with: 'test@test.com'
      fill_in 'パスワード', with: 'test@test.com'
      find('#log_in').click
      visit new_task_path
      fill_in 'タスク名', with: 'タイトル1'
      fill_in 'タスク内容', with: 'コンテント1'
    end
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        click_on '保存'
        expect(page).to have_content 'タイトル1'
        expect(page).to have_content 'コンテント1'
      end
    end
    #ステップ5で作成したテスト
    context 'タスク新規作成時にラベルを登録した場合' do
      it '保存後遷移するタスク詳細画面にラベルが表示される' do
        check 'ラベル1'
        click_on '保存'
        expect(page).to have_content 'ラベル1'
      end
    end
  end

  describe '一覧表示機能' do
    before do
      user = FactoryBot.create(:user)
      task = FactoryBot.create(:task, user: user)
      task = FactoryBot.create(:second_task, user: user)
      task = FactoryBot.create(:third_task, user: user)
      visit new_session_path
      fill_in 'メールアドレス', with: 'test@test.com'
      fill_in 'パスワード', with: 'test@test.com'
      find('#log_in').click
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'タイトル1'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'タイトル1'
      end
    end
    context 'タスクを終了期限でソートした場合' do
      it '終了期限が最も近いタスクが一番上に表示される' do
        click_on '終了期限'
        sleep(0.5)
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'タイトル3'
      end
    end
    context 'タスクを優先度でソートした場合' do
      it '優先度が最も高いタスクが一番上に表示される' do
        click_on '優先度'
        task_list = all('.task_row')
        sleep(0.5)
        expect(task_list[0]).to have_content 'タイトル1'
      end
    end
  end

  describe '詳細表示機能' do
    before do
      user = FactoryBot.create(:user)
      #label = FactoryBot.create(:label)
      @task = FactoryBot.create(:task, user: user)
      visit new_session_path
      fill_in 'メールアドレス', with: 'test@test.com'
      fill_in 'パスワード', with: 'test@test.com'
      find('#log_in').click
    end
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit task_path(@task.id)
        expect(page).to have_content 'タイトル1'
      end
    end
     #ステップ5で作成したテスト
    context 'タスクにラベルが登録されている場合' do
      it "登録されているラベルが表示される" do
        visit new_task_path
        fill_in 'タスク名', with: 'タイトル1'
        fill_in 'タスク内容', with: 'コンテント1'
        check 'ラベル1'
        click_on '保存'
        visit task_path(@task.id)
        expect(page).to have_content 'ラベル1'
      end
    end
  end

  describe '検索機能' do
    before do
      user = FactoryBot.create(:user)
      visit new_session_path
      fill_in 'メールアドレス', with: 'test@test.com'
      fill_in 'パスワード', with: 'test@test.com'
      find('#log_in').click
      task = FactoryBot.create(:task, user: user)
      task = FactoryBot.create(:second_task, user: user)
      task = FactoryBot.create(:third_task, user: user)
      visit tasks_path
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in 'タイトル検索', with: 'タイトル1'
        click_on '検索'
        expect(page).not_to have_content 'タイトル2'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select '未着手', from: 'ステータス検索'
        click_on '検索'
        expect(page).not_to have_content 'タイトル2'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in 'タイトル検索', with: 'タイトル'
        select '未着手', from: 'ステータス検索'
        click_on '検索'
        expect(page).not_to have_content 'タイトル2'
      end
    end
    context 'ラベル名検索した場合' do
      it "そのラベルを登録しているタスクが絞り込まれる" do
        select 'ラベル1', from: 'label_id'
        click_on '検索'
        expect(page).to have_content 'タイトル1'
        expect(page).not_to have_content 'タイトル2'
      end
    end
  end
end
