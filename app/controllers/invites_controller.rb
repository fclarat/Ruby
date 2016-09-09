class InvitesController < ApplicationController
    before_action :set_invite, only: [:show]
    before_action :set_invite_by_token, only: [:confirm, :reject, :postpone]

    def create
        @event = Event.find(params[:event_id])
        @invite = @event.invites.create(Hash["name" => invite_params['name'], "mail" => invite_params['mail'], "confirmed" => 0])

        if @invite.save
            # ExampleMailer.delay.sample_email(@invite)
            ExampleMailer.sample_email(@invite).deliver_now
        end

        redirect_to event_path(@event)
    end

    def show
        # render "invites/status.html.erb"
    end

    def confirm
        respond_to do |format|
            @invite.confirmed = Invite::CONFIRMED_STATUS
            if @invite.save
                format.html { redirect_to @invite, notice: 'Invite was successfully confirmed.' }
            else
                format.json { render json: @invite.errors, status: :unprocessable_entity }
            end
        end
    end

    def reject
        respond_to do |format|
            @invite.confirmed = Invite::REJECTED_STATUS
            if @invite.save
                format.html { redirect_to @invite, notice: 'Invite was successfully rejected.' }
            else
                format.json { render json: @invite.errors, status: :unprocessable_entity }
            end
        end
    end

    def postpone
        respond_to do |format|
            @invite.confirmed = Invite::POSTPONED_STATUS
            if @invite.save
                format.html { redirect_to @invite, notice: 'Invite was successfully postponed.' }
            else
                format.json { render json: @invite.errors, status: :unprocessable_entity }
            end
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_invite
            @invite = Invite.find(params[:id])
        end

        def set_invite_by_token
            @invite = Invite.find_by(token: params[:token])
        end

        def invite_params
            params.require(:invite).permit(:name, :mail)
        end
end
