class ProjectsController < ApplicationController
  def index
    @projects = Current.user.projects
  end
end
