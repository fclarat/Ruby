class AddReceiveEmailsColumnToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :receive_emails, :boolean, default: true, null: false
  end
end
