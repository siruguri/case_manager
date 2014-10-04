module CustomClientProcessors
  class ChoEncoreClientProcessor
    def process(client, form_entry)
      puts ">>> #{form_entry.answers}"

      if form_entry.answer(:no_primary_language)=='' and
          form_entry.answer(:resident_of_alameda)=='Yes' and
          form_entry.answer(:study_participate)=='Yes'
        client.add_flag :find_eligibility, 'Yes'
      end
    end
  end
end
