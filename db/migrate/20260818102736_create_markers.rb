class CreateMarkers < ActiveRecord::Migration[8.1]
  def change
    create_table :markers do |t|
      t.references :list, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
