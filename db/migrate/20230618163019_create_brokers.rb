class CreateBrokers < ActiveRecord::Migration[7.0]
  def change
    create_table :brokers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.boolean :isBroker, default: true

      t.timestamps
    end
  end
end
