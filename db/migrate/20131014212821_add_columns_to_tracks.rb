class AddColumnsToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :type, :string
    add_column :tracks, :lyrics, :text

    change_column :tracks, :type, :string, :null => false
    change_column :tracks, :lyrics, :text, :null => false
  end
end
