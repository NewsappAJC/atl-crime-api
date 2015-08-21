class AddCrimeDetailsToCrimes < ActiveRecord::Migration
  def change
    add_column :crimes, :crime_detail, :string
  end
end
