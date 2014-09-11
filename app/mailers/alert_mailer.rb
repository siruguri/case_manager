class AlertMailer < ActionMailer::Base
  default from: "admin@casemanager.com"

  def alert_to_manager_mail(user)

    @vol = user
    @manager = user.manager

    puts ">>> mailing #{@manager.contact_email}"

    mail to: @manager.contact_email, subject: "Actions checkin needed for #{@vol.full_name}"
  end
end
