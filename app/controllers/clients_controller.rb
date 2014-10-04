class ClientsController < ApplicationController
  load_and_authorize_resource

  def index

  end

  def show
    @client = Client.find params[:id]

    if @client.client_flags
      @flags=(@client.client_flags.inject({}) do |hsh, flg|
                if flg.yes_no_flag
                  hsh[flg.yes_no_flag.key.to_sym]=flg.is_true? 
                else
                  hsh[flg.flag_config.key.to_sym]=flg.flag_value
                end 
                hsh
              end)
    end

    @client_forms = @client.form_entries
  end
end
