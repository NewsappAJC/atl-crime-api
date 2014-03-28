class DropProductsTable < ActiveRecord::Migration
  def up
    drop_table :crimes
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end