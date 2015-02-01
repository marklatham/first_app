class AddDaysLevelToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :days, :float
    add_column :votes, :level, :float
  end
end
