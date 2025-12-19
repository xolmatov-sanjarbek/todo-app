class AddProjectToTodos < ActiveRecord::Migration[8.1]
  # Creates a `project_id` column on the `todos` table with a NOT NULL constraint and a foreign key referencing the `projects` table.
  def change
    add_reference :todos, :project, null: false, foreign_key: true
  end
end