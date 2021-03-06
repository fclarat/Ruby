class ExampleMailer < ApplicationMailer
    default from: "from@example.com"

    def sample_email(invite)
        @invite = invite
        mail(from: ENV['EMAIL_FROM'], to: @invite.mail, subject: "Se ha invitado al evento #{@invite.event.name}")

        # Mailjet::Send.create(
        #     from_email: ENV['MAILJET_DEFAULT_FROM'],
        #     from_name: "Mailjet Pilot",
        #     subject: "Your email flight plan!",
        #     text_part: "Dear passenger, welcome to Mailjet! May the delivery force be with you!",
        #     html_part: render_to_string('example_mailer/sample_email').to_str,
        #     recipients: [{ 'Email'=> @invite.mail}])


        # mail(from: ENV['MAILJET_DEFAULT_FROM'], to: @invite.mail, subject: 'Sample Email')
        # Mailjet::MessageDelivery.create(from: ENV['MAILJET_DEFAULT_FROM'], to: @invite.mail, subject: "Mailjet is awesome", text: "Yes, it is!")

        # # First, instantiate the Mailgun Client with your API key
        # mg_client = Mailgun::Client.new ENV['MAILGUN_API_KEY']
        # mb_obj = Mailgun::MessageBuilder.new

        # # Define the from address.
        # mb_obj.from ENV['EMAIL_FROM']
        
        # # Define a to recipient.
        # mb_obj.add_recipient :to, @invite.mail
        
        # # Define the subject.
        # mb_obj.subject "Mailgun HTML Example"
        
        # # Define the body of the message.
        # # mb_obj.body_text render_to_string('/example_mailer/sample_email.text.erb', layout: false, content_type: 'text/plain').to_str
        
        # # Define the body of the message.
        # mb_obj.body_html render_to_string('example_mailer/sample_email').to_str
        # # mb_obj.body_text "EMAIL!"

        # # Finally, send your message using the client
        # mg_client.send_message ENV['MAILGUN_DOMAIN'], mb_obj
    end
end
