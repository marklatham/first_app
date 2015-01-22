class RemoveChannelIndexToStanding < ActiveRecord::Migration
  def change
    remove_index :standings, :channel_id
  end
end
