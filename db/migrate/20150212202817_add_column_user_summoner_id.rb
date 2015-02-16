class AddColumnUserSummonerId < ActiveRecord::Migration
  def change
    add_column :users, :summoner_id, :string
  end
end
