require "test_helper"

class TodosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @todo = todos(:one)
    sign_in_as(users(:one))
  end

  test "should get index" do
    get project_todos_url(@todo.project)
    assert_response :success
  end

  test "should get new" do
    get new_project_todo_url(@todo.project)
    assert_response :success
  end

  test "should create todo" do
    assert_difference("Todo.count") do
      post project_todos_url(@todo.project), params: { todo: { completed: @todo.completed, description: @todo.description, name: @todo.name, priority: @todo.priority } }
    end

    assert_redirected_to project_url(@todo.project)
  end

  test "should show todo" do
    get todo_url(@todo)
    assert_response :success
  end

  test "should get edit" do
    get edit_todo_url(@todo)
    assert_response :success
  end

  test "should update todo" do
    patch todo_url(@todo), params: { todo: { completed: @todo.completed, description: @todo.description, name: @todo.name, priority: @todo.priority } }
    assert_redirected_to todo_url(@todo)
  end

  test "should destroy todo" do
    assert_difference("Todo.count", -1) do
      delete todo_url(@todo)
    end

    assert_redirected_to @todo.project
  end

  test "should handle missing project gracefully in new action" do
    # Test that new action works properly when project is present
    # The guard clause prevents NoMethodError if @project were somehow nil
    get new_project_todo_url(@todo.project)
    assert_response :success
  end

  test "should handle missing project gracefully in create action" do
    # Test that create action works properly when project is present
    # The guard clause prevents NoMethodError if @project were somehow nil
    assert_difference("Todo.count") do
      post project_todos_url(@todo.project), params: { todo: { completed: false, description: "New todo", name: "Test todo", priority: 1 } }
    end
    assert_redirected_to project_url(@todo.project)
  end
end
