class ChangeColumnNullTasks < ActiveRecord::Migration[5.2]
  change_column :tasks, :title, :string, null: false
end
