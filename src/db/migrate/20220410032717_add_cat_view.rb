# Project name: AMSTR (ACCR Management System Tracker)
# Description: Pro-Bono Tracker for ACCR to oversee work done on several cases
# Filename: 20220410032717_add_cat_view.rb
# Description: Creates a view with the top 3 categories for a given user
# Last modified on: 4/13/22

class AddCatView < ActiveRecord::Migration[6.0]
  def change
  execute <<-SQL
  CREATE OR REPLACE VIEW view_name AS
  SELECT user_id, project_id, SUM(fees) AS FeeSum
  FROM Donations
  GROUP by project_id, user_id
  ORDER BY FeeSum DESC
  FETCH FIRST 2 ROWS ONLY;
  SQL
  end
end
