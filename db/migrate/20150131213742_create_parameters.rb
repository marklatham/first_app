class CreateParameters < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
      t.datetime :as_of
      t.float :days_full_value
      t.float :days_valid
      t.float :interpolation_range
      t.float :spread
      t.float :ip_level
      t.string :note

      t.timestamps
    end
  end
end
