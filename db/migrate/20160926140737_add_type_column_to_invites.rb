class AddTypeColumnToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :type, :string, default: 'invite', null: false
  end
end
	