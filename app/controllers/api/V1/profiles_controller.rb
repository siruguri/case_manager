class Api::V1::ProfilesController < ApplicationController

  def process_cmd
    resp_o = {status: "Unknown error. This shouldn't have happened.", description: '', created_at: ''}

    status = 'fail'
    u = UserAction.new(description: params[:desc])
    u.user = current_user
    if u.save
      status = 'success'

      # Let's set the description from what's in the db to account for model validations/callbacks.
      resp_o[:description]= u.description
      resp_o[:created_at]= u.created_at.to_time.to_s.gsub(/ .\d+$/, '') + " #{Time.now.zone}"
    end

    resp_o[:status]=status
    respond_to do |fmt| 
      fmt.json { render json: resp_o }
    end
  end
end
