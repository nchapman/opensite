class CreateDomains < ActiveRecord::Migration
  def self.up
    create_table :domains do |t|
      t.belongs_to :site
      t.string :fqdn
      t.timestamps
    end
  end

  def self.down
    drop_table :domains
  end
end
