class CreateRents < ActiveRecord::Migration[5.2]
  def change
    create_table :rents do |t|
      t.string :tel
      t.string :fullname
      t.string :address
      t.integer :user_id
      t.integer :micropost_id

      t.timestamps
    end
  end
end
