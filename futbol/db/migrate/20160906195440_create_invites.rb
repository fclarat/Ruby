class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :mail
      t.integer :confirmed
      t.string :name
      t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
