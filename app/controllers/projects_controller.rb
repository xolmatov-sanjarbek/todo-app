class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  def index
    @projects = Current.user.projects
  end

  def show
    @todos = @project.todos
  end

  def new
    @project = Current.user.projects.new
  end

  def create
    @project = Current.user.projects.new(project_params)

    if @project.save
      redirect_to @project, notice: "Project was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy!
    redirect_to projects_url, notice: "Project was successfully destroyed."
  end

  private
    def set_project
      @project = Current.user.projects.find(params.expect(:id))
    end

    def project_params
      params.expect(project: [ :name ])
    end
end
