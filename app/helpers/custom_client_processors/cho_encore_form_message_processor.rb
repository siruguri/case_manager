module CustomClientProcessors
  class ChoEncoreFormMessageProcessor
    def process(form_entry)
      puts ">>> #{form_entry.clients.size}"
      if (form_entry.clients.select { |c| c.has_flag? :find_eligibility }).empty?
        '(Not Eligible)'
      else
        ct = (form_entry.clients.select { |c| c.has_flag? :find_eligibility }).first
        puts ">>> Found valid eligible client #{ct.display_name}"
        "Eligible: Enrol <a href='/form_entries/new?name=Enrolment&client_id=#{ct.id}'>#{ct.display_name}</a>"
      end
    end
  end
end
