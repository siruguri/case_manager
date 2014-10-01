module CustomClientProcessors
  class YouthAliveClientProcessor
    def process(client, form_entry)
      if form_entry.answer(:problems_sleeping)!='Never'
        client.add_flag :intervention, 'BETTER sleep'
      end

      if form_entry.answer(:disturbing_memories)!='Never' || \
        form_entry.answer(:feel_numb)!='Never' || \
        form_entry.answer(:avoid_situation)!='Never'
        client.add_flag :intervention, 'hand massage'
      end

      if form_entry.answer(:everyday_focus)!='Never' || \
        form_entry.answer(:problems_sleeping)!='Never' || \
        form_entry.answer(:on_guard)!='Never' || \
        form_entry.answer(:avoid_situation)!='Never'
        client.add_flag :intervention, 'breathing, if not just done hand massage'
      end

      yes_score = [:everyday_focus, :problems_sleeping, :disturbing_memories, :feel_numb, :on_guard, :avoid_situation].map do |k|
        form_entry.answer k
      end.select { |x| x!='Never' }.size
      
      puts ">>> got yes score of #{yes_score}"
      if yes_score > 2
        client.add_flag :intervention, 'safety plan'
      end

      ptsd_score = [:disturbing_memories, :feel_numb, :on_guard, :avoid_situation].map do |k|
        form_entry.answer k
      end.select { |x| x!='Never' }.size

      if ptsd_score > 2
        client.add_flag :intervention, 'PTSD assessment afterwards'
      end
      
    end
  end
end
