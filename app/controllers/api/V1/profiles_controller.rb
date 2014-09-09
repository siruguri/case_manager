class Api::V1::ProfilesController < ApplicationController
  def process_action
    resp_o = {status: "unknown failure. this shouldn't have happened."}


    respond_to do |fmt|
      fmt.json { render json: resp_o }
    end
  end
end
