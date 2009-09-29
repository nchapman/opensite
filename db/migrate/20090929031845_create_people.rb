class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :salt
      t.string :encrypted_password

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
