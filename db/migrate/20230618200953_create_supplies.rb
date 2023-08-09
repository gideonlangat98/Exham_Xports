class CreateSupplies < ActiveRecord::Migration[7.0]
  def change
    create_table :supplies do |t|
      t.string :supplier_credentials
      t.string :country
      t.string :boxmark
      t.string :type_flower
      t.string :variety
      t.string :s1
      t.integer :quantity
      t.string :boxtype
      t.string :stems
      t.float :cost
      t.float :amount
      t.string :total
      t.string :assign_to
      t.integer :supplier_id, null: true, foreign_key: true

      t.timestamps
    end
  end
end
