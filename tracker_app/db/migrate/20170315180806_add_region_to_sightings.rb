class AddRegionToSightings < ActiveRecord::Migration[5.0]
  def change
    add_column :sightings, :region, :string
  end
end
