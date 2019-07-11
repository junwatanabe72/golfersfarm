class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :image
      t.integer :bscore
      t.integer :distance
      t.string :address
      t.string :hcourse
      t.string :bplace 
      t.integer :status,default: 0, null: false, limit: 1
      t.timestamps
    end
  end
end
