web: bundle exec rails server  -p $PORT thin 
resque:  bundle exec rake resque:work QUEUE=alert_emails
resque_scheduler: bundle exec rake resque:scheduler
