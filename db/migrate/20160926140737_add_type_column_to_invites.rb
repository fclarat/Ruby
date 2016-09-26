class AddTypeColumnToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :invite_type, :string, default: 'invite', null: false
  end
end
	