class MakeNameUniqueInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :name, :string, unique: true
  end
end
