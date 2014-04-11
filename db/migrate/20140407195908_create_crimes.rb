class CreateCrimes < ActiveRecord::Migration
  def change
    create_table :crimes do |t|
      t.integer :offense_id
      t.date :rpt_date
      t.date :occur_date
      t.datetime :occur_time
      t.date :poss_date
      t.datetime :poss_time
      t.string :beat
      t.string :location
      t.string :MaxOfnum_victims
      t.string :Shift
      t.string :UC2_Literal
      t.string :neighborhood
      t.string :x
      t.string :y
    end
  end
end
