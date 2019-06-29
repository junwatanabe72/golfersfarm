class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.references :receiver, foreign_key: {to_table: :users}

      t.timestamps
      
      t.index [:user_id, :receiver_id], unique: true
    end
  end
end
