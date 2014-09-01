class ClientsController < ApplicationController
  def index
    @clients = Client.all
  end

  def show
    @client = Client.find params[:id]

    @forms = FormEntry.joins(:form_cross_references).
      where(form_cross_references: {cross_reference_class: 'Client', cross_reference_id: @client.id})
  end
end
