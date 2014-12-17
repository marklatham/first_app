class AddCustomToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :custom, :boolean
  end
end
