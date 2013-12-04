class AddCategoryToGoods < ActiveRecord::Migration
  def change
    add_reference :goods, :category, :index => true
  end
end
