class TodosController < ApplicationController
  before_action :set_todo, only: %i[ show edit update destroy ]
  before_action :set_project, only: %i[ index new create ], if: -> { params[:project_id].present? }

  ##
  # Loads the list of todos into @todos for rendering the index: uses the current project’s todos when @project is present, otherwise uses the current user’s todos.
  def index
    @todos = @project&.todos || Current.user.todos
  end

  ##
  # Shows the Todo stored in `@todo` and renders the show template.
  def show
  end

  ##
  # Prepares a new Todo associated with the current @project for the new form.
  #
  # Initializes @todo as a new, unsaved Todo belonging to @project so the
  # view can render the creation form.
  def new
    @todo = @project.todos.new
  end

  ##
  # Presents the edit form for the current todo.
  # Expects an instance variable `@todo` to be loaded and renders the edit template.
  def edit
  end

  ##
  # Creates a new Todo under the current project and assigns ownership to the current user.
  #
  # On success:
  # - HTML: redirects to the project with a success notice.
  # - JSON: renders the todo with HTTP status 201 Created and Location header pointing to the todo.
  #
  # On failure:
  # - HTML: re-renders the new template with HTTP status 422 Unprocessable Entity.
  # - JSON: responds with the todo's validation errors and HTTP status 422 Unprocessable Entity.
  def create
    @todo = @project.todos.new(todo_params)
    @todo.user_id = Current.user.id

    respond_to do |format|
      if @todo.save
        format.html { redirect_to @project, notice: "Todo was successfully created." }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  ##
  # Updates the loaded @todo with permitted parameters and responds in HTML or JSON.
  # On success: HTML redirects to the todo with a success notice and status 303 See Other; JSON renders the show template with status 200 OK.
  # On failure: HTML re-renders the edit template with status 422 Unprocessable Entity; JSON responds with the todo's validation errors and status 422.
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to @todo, notice: "Todo was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  ##
  # Destroys the loaded todo and responds with HTML or JSON.
  # For HTML requests, redirects to the todo's project with a success notice and HTTP status 303 (See Other).
  # For JSON requests, responds with no content (HTTP 204).
  def destroy
    @todo.destroy!

    respond_to do |format|
      format.html { redirect_to @todo.project, notice: "Todo was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    ##
    # Loads the current user's project identified by the required `:project_id` parameter and assigns it to `@project`.
    # Raises ActionController::ParameterMissing if `:project_id` is not present and ActiveRecord::RecordNotFound if no matching project exists for the current user.
    # @return [Project] The project found and assigned to `@project`.
    # @raise [ActionController::ParameterMissing] if `:project_id` is missing from params.
    # @raise [ActiveRecord::RecordNotFound] if no project with the given id exists for Current.user.
    def set_project
      @project = Current.user.projects.find(params.expect(:project_id))
    end

    ##
    # Loads the current user's Todo identified by params[:id] into @todo.
    # @raise [ActiveRecord::RecordNotFound] if no matching Todo is found for the current user.
    def set_todo
      @todo = Current.user.todos.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.expect(todo: [ :name, :description, :priority, :completed ])
    end
end