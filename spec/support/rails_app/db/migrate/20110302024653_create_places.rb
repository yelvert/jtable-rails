class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.integer :person_id
      t.string :address
      t.string :city
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :places
  end
end
