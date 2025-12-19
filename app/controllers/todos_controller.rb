class TodosController < ApplicationController
  before_action :set_todo, only: %i[ show edit update destroy ]
  before_action :set_project, only: %i[ index new create ], if: -> { params[:project_id].present? }

  # GET /projects/:project_id/todos
  def index
    @todos = @project&.todos || Current.user.todos
  end

  # GET /todos/1
  def show
  end

  # GET /projects/:project_id/todos/new
  def new
    @todo = @project.todos.new
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /projects/:project_id/todos
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

  # PATCH/PUT /todos/1
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

  # DELETE /todos/1
  def destroy
    @todo.destroy!

    respond_to do |format|
      format.html { redirect_to @todo.project, notice: "Todo was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = Current.user.projects.find(params.expect(:project_id))
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Current.user.todos.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.expect(todo: [ :name, :description, :priority, :completed ])
    end
end
