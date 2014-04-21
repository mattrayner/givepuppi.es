class AddImagesToPuppies < ActiveRecord::Migration
  def self.up
      add_attachment :puppies, :image
  end

  def self.down
      remove_attachment :puppies, :image
  end
end
