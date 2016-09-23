class InvitesController < ApplicationController
    before_action :set_invite, only: [:show]
    before_action :set_invite_by_token, only: [:confirm, :reject, :postpone]

    def create
        @event = Event.find(params[:event_id])
        @invite = @event.invites.create(Hash[
            "name" => invite_params['name'],
            "mail" => invite_params['mail'],
            "confirmed" => 0,
            "receive_emails" => true
        ])
        redirect_to event_path(@event)
    end

    def show
        # render "invites/status.html.erb"
    end

    def confirm
        @invite.confirmed = Invite::CONFIRMED_STATUS
        if @invite.save
            send_emails @invite
            render :confirmed, layout: false
        end
    end

    def reject
        @invite.confirmed = Invite::REJECTED_STATUS
        if @invite.save
            send_emails @invite
            render :rejected, layout: false 
        end
    end

    def postpone
        @invite.confirmed = Invite::POSTPONED_STATUS
        if @invite.save
            send_emails @invite
            render :postponed, layout: false
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

        def send_emails(invite)
              invite.event.invites.where(receive_emails: true).each do |invite|
                ConfirmedMailer.sample_email(invite).deliver_later
            end
        end 
end
