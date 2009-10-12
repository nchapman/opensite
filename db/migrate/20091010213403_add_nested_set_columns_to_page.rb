class AddNestedSetColumnsToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :parent_id, :integer
    add_column :pages, :lft, :integer
    add_column :pages, :rgt, :integer
    add_index :pages, :parent_id
    add_index :pages, [:lft, :rgt]
  end

  def self.down
    remove_index :pages, :parent_id
    remove_index :pages, [:lft, :rgt]
    remove_column :pages, :parent_id
    remove_column :pages, :lft
    remove_column :pages, :rgt
  end
end
