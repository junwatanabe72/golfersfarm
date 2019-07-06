class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :content
      t.string :image
      t.references :user, foreign_key: true
      t.references :receiver, foreign_key: {to_table: :users}

      t.timestamps
      
     
    end
  end
end
