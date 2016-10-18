class ReorganiseRate < ActiveRecord::Migration
  def change
    remove_column :templates, :rate_eur, :integer
    remove_column :templates, :rate_interval, :string
    add_column :templates, :rate, :string
  end
end
