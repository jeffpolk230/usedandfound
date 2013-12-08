class CreateQuotations < ActiveRecord::Migration
  def change
    create_table :quotations do |t|
      t.string :author_name
      t.string :quote_category
      t.text :quote

      t.timestamps
    end
  end
end
