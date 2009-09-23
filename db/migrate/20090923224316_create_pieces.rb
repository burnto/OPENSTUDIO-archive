class CreatePieces < ActiveRecord::Migration
  def self.up
    create_table :pieces do |t|
      t.string :title
      t.integer :owner_id
      t.integer :creator_id
      t.string :legacy_id

      t.timestamps
    end
  end

  def self.down
    drop_table :pieces
  end
end
