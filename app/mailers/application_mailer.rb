# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@local-farm-raised.com"
  layout "mailer"
end
