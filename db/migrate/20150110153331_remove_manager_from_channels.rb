class RemoveManagerFromChannels < ActiveRecord::Migration
  def change
    remove_reference :channels, :manager, index: true
  end
end
