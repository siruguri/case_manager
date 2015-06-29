class AppointmentRequestsController < ApplicationController
  load_and_authorize_resource
  
  def new
    @user = current_user
  end

  def show
  end
  
  def create
  end
end
