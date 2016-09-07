class InvitesController < ApplicationController
	def create
		@event = Event.find(params[:event_id])
		@invite = @event.invites.create(Hash["name" => invite_params['name'], "mail" => invite_params['mail'], "confirmed" => 1])

        if @invite.save
            ExampleMailer.delay.sample_email(@invite)
        end

		redirect_to event_path(@event)
	end

	private
		def invite_params
			params.require(:invite).permit(:name, :mail)
		end
end
