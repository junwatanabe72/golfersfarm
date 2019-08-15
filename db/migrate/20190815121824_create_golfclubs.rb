class CreateGolfclubs < ActiveRecord::Migration[5.2]
  def change
    create_table :golfclubs do |t|
      t.string :driver
      t.string :dshaft
      t.string :wood
      t.string :ut
      t.string :iron
      t.string :wedge
      t.string :putter
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
