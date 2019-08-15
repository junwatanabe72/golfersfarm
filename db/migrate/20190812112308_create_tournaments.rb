class CreateTournaments < ActiveRecord::Migration[5.2]
  def change
    create_table :tournaments do |t|
      t.string :content
      t.string :url
      t.string :rank
      t.integer :year
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
