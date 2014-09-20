module Api
  module V1
    class ProfilesController < ApiBaseController
      def process_cmd
        u = UserAction.new(description: params[:desc])
        u.user = current_user
        if u.save
          # Let's set the description from what's in the db to account for model validations/callbacks.
          set_response_field(:description, u.description)
          set_response_field(:created_at,  u.created_at.to_time.to_s.gsub(/ .\d+$/, '') + " #{Time.now.zone}")
          set_response_success
        else
          set_response_failure
        end

        send_response
      end
    end
  end
end
