# frozen_string_literal: true

# Create global configuration model for whatever use
# in necessary for this app
class CreateAppConfigs < ActiveRecord::Migration[6.0]
  def change
    create_table :app_configs do |t|
      t.text :name, default: 'AMSTR'
      t.text :logo_url

      t.timestamps
    end
  end
end
