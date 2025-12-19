class AddProjectToTodos < ActiveRecord::Migration[8.1]
  def change
    add_reference :todos, :project, foreign_key: true
  end
end
