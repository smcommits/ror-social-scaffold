class RemovaStatusFromFriendship < ActiveRecord::Migration[5.2]
  def change
    remove_column :friendships, :status, :integer
  end
end
