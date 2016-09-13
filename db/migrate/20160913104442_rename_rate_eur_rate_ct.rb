class RenameRateEurRateCt < ActiveRecord::Migration
  def change
    rename_column :articles, :rate_eur, :rate_ct
    rename_column :templates, :rate_eur, :rate_ct
  end
end
