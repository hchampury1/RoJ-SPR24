# Project name: AMSTR
# Description: ACCR Management System Tracker 
# Filename: worklog.rb
# Description: Represents worklog data and helps with searches
# Last modified on: 4/13/22

class Worklog < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :entered_by, optional: true

  # Returns the fields to be searched as one continuous, all-lowercase string
  def search_in
    search_str = ''
    user = User.find_by(id: user_id)
    project = Project.find_by(id: project_id)
    [ desc_summary, desc_body, user.first_name, user.last_name, project.name ].each do |field|
      search_str += field.to_s + ' '
    end
    search_str.downcase
  end

# perform search on description
  class << self   # this line is equivalent of implementing something like "def Worklog.search(query)"
    def search(query)
      if query.nil? || (not Worklog.method_defined? :search_in) then
        return
      end

      Worklog.all.select {|record| record.search_in.index(query.downcase) }
    end
  end

  #download worklogs to csv file
  def self.to_csv
    attributes = %w{Entry User Project Summary Description Hours Fee Date Entered_By Created_at Updated_at}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |worklog|
        csv << [worklog.id, "#{worklog.user.first_name} #{worklog.user.last_name}", worklog.project.name, worklog.desc_summary, worklog.desc_body, worklog.hours, worklog.fee, worklog.date, worklog.entered_by, worklog.created_at, worklog.updated_at]
      end
    end
  end

end
