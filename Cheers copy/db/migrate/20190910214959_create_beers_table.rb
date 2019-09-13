class CreateBeersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :beers do |t|
      t.string :name
      t.float :abv
      t.integer :ibu
      t.string :description
      t.references :brewery, foreign_key: true
      t.references :category, foreign_key: true
    end
  end
end
