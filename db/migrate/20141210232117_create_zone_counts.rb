class CreateZoneCounts < ActiveRecord::Migration
  def change
    create_table :zone_counts do |t|

      t.timestamps
    end
  end
end
