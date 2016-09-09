# Preview all emails at http://localhost:3000/rails/mailers/confirmed_mailer
class ConfirmedMailerPreview < ActionMailer::Preview
    def sample_email_preview
        ConfirmedMailer.sample_email(Invite.first)
    end
end
