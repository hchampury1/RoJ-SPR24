class Project < ApplicationRecord
  has_and_belongs_to_many :users

  def self.search search
    if search
      project = Project.find_by(name: search)
      if project
        self.where(project_id: project)
      else
        @projects = Project.all
      end
    else
      @projects = Project.all
    end
  end
end
