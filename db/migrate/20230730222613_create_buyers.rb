class CreateBuyers < ActiveRecord::Migration[7.0]
  def change
    create_table :buyers do |t|
      t.string :buyer_name
      t.string :email
      t.string :password_digest
      t.boolean :isBuyer, default: true
      t.integer :broker_id, null: true, foreign_key: true

      t.timestamps
    end
  end
end
