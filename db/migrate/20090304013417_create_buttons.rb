class CreateButtons < ActiveRecord::Migration
  def self.up
    create_table :buttons do |t|
      t.string :site_uid
      t.string :nickname
      t.text :code
      t.boolean :default

      t.timestamps
    end
  end

  def self.down
    drop_table :buttons
  end
end
