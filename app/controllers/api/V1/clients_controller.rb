module Api
  module V1
    class ClientsController < ApiBaseController
      def search
        fill_in = params[:fill_in]
        if /last_name/.match fill_in
          search_attr='last_name'
        else
          search_attr='first_name'
        end

        @clients = Client.where "#{search_attr} like ?", "%#{params[:q]}%"
        autolist = @clients.map do |ct|
          if can?(:read, ct)
            resp={id: ct.id, label: ct.send(search_attr.to_sym), last_name: ct.last_name,
              first_name: ct.first_name, mr_number: ct.mr_number}
          end
          resp
        end.compact
        
        puts ">> response #{autolist.to_json}"

        respond_to do |fmt|
          fmt.json { render json: autolist }
        end
      end

      def update
        # Check if the role is allowed to execute this action
        update_action = params[:api_action]
        if !(action_rec = ApiAction.find_by_name(update_action)) or cannot?(:run_api_command, action_rec)
          send_response_failure
          return
        end

        # if it's a client specific update, check if the user has access to that resource
        ct=nil
        if params[:id]
          ct = Client.find params[:id]
          if ct.nil? or cannot?(:update, ct)
            send_response_failure
          end
        end

        if eval("#{action_rec.name}(ct, params)")
          set_response_success
          send_response
        else
          send_response_failure
        end
      end

      private
      # TODO none of these methods check if the underlying DB action fails
      def toggle_client_flag(ct, params)
        return if ct.nil?

        if(flag = ct.client_flags.select { |x| x.yes_no_flag and x.yes_no_flag.key == params[:flag_name]}.first)
          flag.toggle_value
          flag.save
        else
          # client hasn't been flagged so far, so now we flag it.
          flag=ClientFlag.new flag_value: 'yes'
          flag.yes_no_flag = YesNoFlag.find_by_key params[:flag_name]
          flag.save
          ct.client_flags << flag
        end

        set_response_field('flag_value', flag.flag_value.capitalize)

        true
      end

      def add_note(ct, params)
        return if ct.nil?

        f=FieldNote.new(author: current_user, client: ct, entry: params[:entry])
        f.save
        ct.field_notes << f

        set_response_field('entry', f.entry)

        true
      end

      def update_case_contact(ct, params)
        ct.case_contact_id = params[:new_case_contact_id]
        if ct.save
          true
        else
          false
        end
      end

      def set_client_priorities(ct, params)
        send_list = params[:priorities].each_with_index.map { |p, idx| [p.to_i, idx] }
        Client.change_priorities send_list, -1
        
        true
      end
    end
  end
end
