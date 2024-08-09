class AddBannedUntilToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :banned_until, :datetime
  end
end
