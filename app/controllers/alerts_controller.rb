class AlertsController < ApplicationController
  def run_alert
    Resque.enqueue(SendMailAlert, params[:id])
  end
end
