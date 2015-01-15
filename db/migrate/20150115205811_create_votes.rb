class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.float :share
      t.references :channel, index: true
      t.references :user, index: true
      t.string :ip
      t.string :agent

      t.timestamps
    end
  end
end
