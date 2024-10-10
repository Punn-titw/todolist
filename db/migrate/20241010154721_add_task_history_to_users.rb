class AddTaskHistoryToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :task_history, :text
  end
end
