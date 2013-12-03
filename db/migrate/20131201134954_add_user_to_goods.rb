class AddUserToGoods < ActiveRecord::Migration
  def change
    #add_column :goods, :user_id, :integer
    add_reference :goods, :user
  end
end
