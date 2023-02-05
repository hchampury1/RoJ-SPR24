# Project name: AMSTR (ACCR Management System Tracker)
# Description: Pro-Bono Tracker for ACCR to oversee work done on several cases
# Filename: 20220410032717_add_cat_view.rb
# Description: Alters the view name from ViewName to category_views
# Last modified on: 4/13/22

class AlterViewName < ActiveRecord::Migration[6.0]
  def change
    execute <<-SQL
    ALTER VIEW view_name RENAME TO category_views;
    SQL
  end
end
