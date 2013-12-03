class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.string :title
      t.float  :price
      t.text   :description
      t.string :status
      
      t.timestamps
    end
  end
end
