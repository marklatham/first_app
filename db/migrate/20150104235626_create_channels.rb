class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name
      t.belongs_to :manager, index: true
      t.references :display, index: true

      t.timestamps
    end
  end
end
