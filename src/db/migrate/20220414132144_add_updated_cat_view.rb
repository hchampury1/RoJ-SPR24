class AddUpdatedCatView < ActiveRecord::Migration[6.0]
  def change
    execute <<-SQL
    CREATE OR REPLACE VIEW category_views AS
    SELECT user_id, project_id, SUM(fees) AS FeeSum
    FROM Donations
    GROUP by project_id, user_id
    ORDER BY FeeSum DESC
    SQL
    end
end
