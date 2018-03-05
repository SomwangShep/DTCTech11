class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.string :email
      t.string :token
      t.integer :chef_id

      t.timestamps
    end
  end
end
