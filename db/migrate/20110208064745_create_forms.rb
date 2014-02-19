class CreateForms < ActiveRecord::Migration
  def self.up
    create_table :forms do |t|
      t.string :title, :null => false
      t.text :comment
      t.string :template_name

      t.timestamps
    end
  end

  def self.down
    drop_table :forms
  end
end