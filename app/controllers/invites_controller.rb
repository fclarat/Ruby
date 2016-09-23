class InvitesController < ApplicationController
    before_action :set_invite, only: [:show]
    before_action :set_invite_by_token, only: [:confirm, :reject, :postpone, :show_info, :edit_info, :update_info]

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

    def show_info
    end

    def edit_info
    end

    def update_info
        if @invite.update(invite_update_info_params)
            redirect_to({ action: 'show_info' }, notice: "Se actualizaron los datos.")
        else
            render :edit_info
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

        def invite_update_info_params
            params.require(:invite).permit(:name, :receive_emails, :confirmed)
        end

        def send_emails(invite)
              invite.event.invites.where(receive_emails: true).each do |invite|
                ConfirmedMailer.sample_email(invite).deliver_later
            end
        end 
end
