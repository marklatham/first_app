class AddUniqueChannelIndexToStanding < ActiveRecord::Migration
  def change
    add_index :standings, :channel_id, unique: true
  end
end
