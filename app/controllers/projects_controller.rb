class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  ##
  # Lists projects for the current user and makes them available to the view.
  # Assigns the current user's projects to `@projects` for rendering in the index template.
  def index
    @projects = Current.user.projects
  end

  ##
  # Prepares the project's todos for the show view by assigning them to @todos.
  # Relies on @project being set (for example by a before_action).
  def show
    @todos = @project.todos
  end

  ##
  # Initializes a new Project associated with the current user for use in the new project form.
  def new
    @project = Current.user.projects.new
  end

  ##
  # Creates a new project for the current user and responds by redirecting on success or re-rendering the form on failure.
  #
  # On successful creation, redirects to the created project. On failure, renders the new template with HTTP status 422 Unprocessable Entity.
  def create
    @project = Current.user.projects.new(project_params)

    if @project.save
      redirect_to @project
    else
      render :new, status: :unprocessable_entity
    end
  end

  ##
  # Renders the edit form for the current project.
  # The project to edit must be assigned to `@project` before this action is called.
  def edit
  end

  ##
  # Updates the loaded project using permitted parameters and navigates based on the outcome.
  # On successful update, redirects to the project's show page with a success notice.
  # On failure, re-renders the edit template with HTTP status 422 (unprocessable entity).
  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  ##
  # Destroys the current project and redirects to the projects index with a success notice.
  # After successful destruction, redirects to the projects listing and sets a flash notice.
  # @raise [ActiveRecord::RecordNotDestroyed] if the record could not be destroyed.
  def destroy
    @project.destroy!
    redirect_to projects_url, notice: "Project was successfully destroyed."
  end

  private
    ##
    # Loads the project with the id from params scoped to the current user and assigns it to @project.
    #
    # The lookup uses the request `params[:id]` to find a project that belongs to `Current.user`.
    # @raise [ActiveRecord::RecordNotFound] if no project with the given id exists for the current user.
    def set_project
      @project = Current.user.projects.find(params.expect(:id))
    end

    ##
    # Extracts and permits the `:name` attribute from the incoming `project` parameters.
    # @return [ActionController::Parameters] The permitted `project` parameters containing the `:name` key.
    def project_params
      params.expect(project: [ :name ])
    end
end