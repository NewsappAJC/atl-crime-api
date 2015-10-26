class AddNpuToCrimes < ActiveRecord::Migration
  def change
    add_column :crimes, :npu, :string
  end
end
