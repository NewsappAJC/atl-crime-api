class CreateCrimes < ActiveRecord::Migration
  def change
    create_table :crimes do |t|
      t.integer :offense_id
      t.string :rpt_date
      t.string :occur_date
      t.string :occur_time
      t.string :poss_date
      t.string :poss_time
      t.integer :beat
      t.string :location
      t.integer :MaxOfnum_victims
      t.string :Shift
      t.string :UC2_Literal
      t.string :neighborhood
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end
end
