class SendEmailJob < ActiveJob::Base
  queue_as :default

  def perform(invite)
    @invite = invite
    ExampleMailer.sample_email(@invite).deliver_later
  end
end
