class RenameTemplateToStockitem < ActiveRecord::Migration
  def change
    rename_table :templates, :stockitems
    remove_reference :articles, :template
    add_reference :articles, :stockitem, index: true, foreign_key: true
  end
end
