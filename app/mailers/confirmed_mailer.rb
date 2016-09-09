class ConfirmedMailer < ApplicationMailer
    def sample_email(invite)
        @invite = invite
        @event = @invite.event
        mail(from: ENV['EMAIL_FROM'], to: @invite.mail, subject: "Evento: #{@event.name} - Update")
    end
end
