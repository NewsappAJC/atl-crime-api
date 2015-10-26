class CreateCrimes < ActiveRecord::Migration
  def change
    create_table :crimes do |t|
      t.integer :crime_id
      t.string :offense_id
      t.string :rpt_date
      t.datetime :occur_date
      t.string :occur_time
      t.string :poss_date
      t.string :poss_time
      t.string :beat
      t.string :location
      t.string :MaxOfnum_victims
      t.string :Shift
      t.string :neighborhood
      t.string :x
      t.string :y
      t.string :crime
      t.string :zone
      t.string :violent
      t.string :npu
    end
  end
end
