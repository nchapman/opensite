class CreateTemplates < ActiveRecord::Migration
  def self.up
    create_table :templates do |t|
      t.belongs_to :site
      t.string :name
      t.text :content
      t.timestamps
      
      t.index :site_id
      t.index [:site_id, :name]
    end
  end

  def self.down
    drop_table :templates
  end
end
