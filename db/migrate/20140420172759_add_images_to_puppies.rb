class AddImagesToPuppies < ActiveRecord::Migration
  def self.up
      add_attachment :puppies, :avatar
  end

  def self.down
      remove_attachment :puppies, :avatar
  end
end
