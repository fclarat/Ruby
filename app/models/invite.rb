class Invite < ActiveRecord::Base
    UNKNOWN_STATUS = 0
    CONFIRMED_STATUS = 1
    REJECTED_STATUS = 2
    POSTPONED_STATUS = 3

    has_secure_token
    belongs_to :event
end

# add_column :invites, :receive_emails, :boolean, defualt: 1, null: false
# add_column :invites, :token, :string
# create_table :invites do |t|
#       t.string :mail
#       t.integer :confirmed
#       t.string :name
#       t.references :event, index: true, foreign_key: true

#       t.timestamps null: false
#     end