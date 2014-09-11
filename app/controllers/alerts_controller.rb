class AlertsController < ApplicationController
  def run_alert
    Resque.enqueue(SendMailAlert, params[:id])
    # SendMailAlert.perform

    render nothing: true
  end
end
