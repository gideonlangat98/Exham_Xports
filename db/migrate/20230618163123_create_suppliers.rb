class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :supplier_name
      t.string :email
      t.string :password_digest
      t.boolean :isSupplier, default: true
      t.integer :broker_id, null: true, foreign_key: true

      t.timestamps
    end
  end
end
