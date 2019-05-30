class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
      t.integer :genre_number
      t.string :genre_name
      t.string :product
      t.timestamps
    end
  end
end
