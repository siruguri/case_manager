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
        update_action = params[:api_action]
        ct = Client.find params[:id]

        if ct.nil? or !(action_available? update_action) or cannot?(:update, ct)
          set_response_failure
        else
          eval("#{update_action}(ct, params)")
        end
        send_response
      end

      private
      def action_available?(action)
        return true if action == 'toggle_client_flag' or action == 'add_note'
        return false
      end

      def toggle_client_flag(ct, params)
        if(flag = ct.client_flags.select { |x| x.yes_no_flag.key == params[:flag_name]}.first)
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
        set_response_success
      end
      def add_note(ct, params)
        f=FieldNote.new(author: current_user, client: ct, entry: params[:entry])
        f.save
        ct.field_notes << f

        set_response_field('entry', f.entry)
        set_response_success
      end
    end
  end
end
