class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :good, index: true
      t.references :user
      t.timestamps
    end
  end
end
