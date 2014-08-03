class AddDisabbledFlagToPuppy < ActiveRecord::Migration
  def change
    add_column :puppies, :disabled, :boolean, default: false
    add_index :puppies, :disabled
  end
end
