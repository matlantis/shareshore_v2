class ChangeRateEurToFloat < ActiveRecord::Migration[4.2]
  def up
    change_column :articles, :rate_eur, :float
    change_column :templates, :rate_eur, :float
  end

  def down
    change_column :articles, :rate_eur, :integer
    change_column :templates, :rate_eur, :integer
  end
end
