class DashboardController < ApplicationController
  layout "dash", only: :dash

  def dash
  end
  def log_hours
  end
  def view_stats
  end
  def view_report
  end

#report page in separate subfolder in "views" --> report > index.html.erb

end
