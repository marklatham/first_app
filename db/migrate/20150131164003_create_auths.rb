class CreateAuths < ActiveRecord::Migration
  def change
    create_table :auths do |t|
      t.references :user, index: true
      t.float :level
      t.string :note

      t.timestamps
    end
  end
end
