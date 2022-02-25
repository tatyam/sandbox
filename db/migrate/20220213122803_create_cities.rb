class CreateCities < ActiveRecord::Migration[7.0]
  def change
    create_table :cities do |t|
      t.string :name, limit: 20
      t.string :en_name, limit: 30
      t.string :country, limit: 2
      t.float  :latitude
      t.float  :longitude
      t.boolean :deleted, default: false, null: false

      t.timestamps
    end
  end
end
