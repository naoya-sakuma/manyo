require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'タスク名', with: 'タイトル1'
        fill_in 'タスク内容', with: 'コンテント1'
        click_on '登録'
        expect(page).to have_content 'タイトル1'
        expect(page).to have_content 'コンテント1'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task)
        visit tasks_path
        expect(page).to have_content 'タイトル1'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task = FactoryBot.create(:task)
        task = FactoryBot.create(:second_task)
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'タイトル1'
      end
    end
    context 'タスクを終了期限でソートした場合' do
      it '終了期限が最も近いタスクが一番上に表示される' do
        task = FactoryBot.create(:task)
        task = FactoryBot.create(:second_task)
        task = FactoryBot.create(:third_task)
        visit tasks_path
        click_on '終了期限順'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'タイトル3'
      end
    end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:task)
         visit task_path(1)
         expect(page).to have_content 'タイトル1'
       end
     end
  end

  describe '検索機能' do
    before do
      task = FactoryBot.create(:task)
      task = FactoryBot.create(:second_task)
      task = FactoryBot.create(:third_task)
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in 'タイトル検索', with: 'タイトル1'
        click_on '検索'
        expect(page).not_to have_content 'タイトル2'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select '未着手', from: 'ステータス検索'
        click_on '検索'
        expect(page).not_to have_content 'タイトル2'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          visit tasks_path
          fill_in 'タイトル検索', with: 'タイトル'
          select '未着手', from: 'ステータス検索'
          click_on '検索'
          expect(page).not_to have_content 'タイトル2'
      end
    end
  end
end
