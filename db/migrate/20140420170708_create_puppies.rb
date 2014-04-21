class CreatePuppies < ActiveRecord::Migration
  def change
    create_table :puppies do |t|
      t.string :orientation, length: 3
      t.string :type, length: 25, default: 'puppy'
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
