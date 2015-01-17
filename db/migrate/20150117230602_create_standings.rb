class CreateStandings < ActiveRecord::Migration
  def change
    create_table :standings do |t|
      t.references :channel, index: true
      t.integer :rank
      t.float :share
      t.float :count0
      t.float :count1
      t.datetime :tallied_at

      t.timestamps
    end
  end
end
