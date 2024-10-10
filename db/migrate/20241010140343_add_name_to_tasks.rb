class AddNameToTasks < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :name, :string
  end
end
