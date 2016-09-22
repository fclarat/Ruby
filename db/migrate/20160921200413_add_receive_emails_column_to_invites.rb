class AddReceiveEmailsColumnToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :receive_emails, :boolean, defualt: 1, null: false
  end
end
