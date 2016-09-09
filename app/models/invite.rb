class Invite < ActiveRecord::Base
    UNKNOWN_STATUS = 0
    CONFIRMED_STATUS = 1
    REJECTED_STATUS = 2
    POSTPONED_STATUS = 3

    has_secure_token
    belongs_to :event
end
