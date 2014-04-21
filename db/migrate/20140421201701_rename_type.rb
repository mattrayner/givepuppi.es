class RenameType < ActiveRecord::Migration
  def self.up
    rename_column :puppies, :type, :pup_type
  end

  def self.down
    rename_column :puppies, :pup_type, :type
  end
end
