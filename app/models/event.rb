class Event < ActiveRecord::Base
	belongs_to :user
    has_many :invites, :dependent => :destroy
end
