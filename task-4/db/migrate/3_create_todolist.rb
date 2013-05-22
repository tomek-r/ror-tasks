class CreateTodolist < ActiveRecord::Migration
  def change
    create_table :todo_list do |t|
      t.string :title
      t.integer :user_id
    end
  end
end
