class ApplicationMailer < ActionMailer::Base
  default from: "Antigravity LMS <#{ENV.fetch("MAILER_SENDER", "contato@antigravitylms.com")}>"
  layout "mailer"
end
