class AddDefaultRoomToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:users, :room_id, 1)
  end
end
