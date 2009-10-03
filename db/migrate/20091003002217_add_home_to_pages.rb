class AddHomeToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :home, :boolean
  end

  def self.down
    remove_column :pages, :home
  end
end
