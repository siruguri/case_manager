class SendMailAlert
# Resque class to send a mail alert when necessary
  @queue = :alert_emails

  def self.perform
    # Check among Users, who has actions dating more than a specified number of days.

    need_alerts = User.all.select do |u|
      if u.has_role('volunteer') and !u.is_admin? 
        current=false
        u.user_actions.each do |act|
          if act.created_at > Time.now - 15.days # Need to add type of action here
            current=true
          end
        end
        
        !current
      else
        false
      end
    end

    need_alerts.each do |u|
      AlertMailer.alert_to_manager_mail(u).deliver
    end
    nil
  end

end
