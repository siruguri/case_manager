class SendMailAlert
# Resque class to send a mail alert when necessary
  @queue = :alert_emails

  def self.perform(id)
    Client.create(first_name: 'dummy')
    puts "In perform for SendMailAlert: got #{id}"
  end

end
