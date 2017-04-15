class RenameHowtoToTransport < ActiveRecord::Migration[5.0]
  def change
    rename_column :searches, :howto, :transport
  end
end
