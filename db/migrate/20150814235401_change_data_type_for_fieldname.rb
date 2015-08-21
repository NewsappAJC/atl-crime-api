class ChangeDataTypeForFieldname < ActiveRecord::Migration
  def self.up
    change_table :crimes do |t|
      t.change :offense_id, :bigint
    end
  end
  def self.down
    change_table :crimes do |t|
      t.change :offense_id, :int
    end
  end
end