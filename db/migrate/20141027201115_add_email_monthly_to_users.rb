class AddEmailMonthlyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_monthly, :boolean, default: false, null: false
  end
end
