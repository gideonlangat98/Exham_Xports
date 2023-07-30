class CreateBuyerFoams < ActiveRecord::Migration[7.0]
  def change
    create_table :buyer_foams do |t|
      t.string :supplier_name
      t.string :country
      t.string :boxMark
      t.string :variety
      t.string :s1
      t.string :stems
      t.integer :quantity
      t.string :boxtype
      t.float :cost
      t.float :amount
      t.float :price
      t.float :total
      t.integer :duty
      t.string :assigned_to
      t.integer :buyer_id, null: true, foreign_key: true

      t.timestamps
    end
  end
end
