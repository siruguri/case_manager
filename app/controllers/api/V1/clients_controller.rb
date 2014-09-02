class Api::V1::ClientsController < ApplicationController
  def search
    fill_in = params[:fill_in]
    if /last_name/.match fill_in
      search_attr='last_name'
    else
      search_attr='first_name'
    end

    puts ">> Searching for #{search_attr} like #{params[:q]}"
    @clients = Client.where "#{search_attr} like ?", "%#{params[:q]}%"
    autolist = @clients.map do |ct|
      {id: ct.id, label: ct.send(search_attr.to_sym), last_name: ct.last_name,
      first_name: ct.first_name, mr_number: ct.mr_number}
    end

    respond_to do |fmt|
      fmt.json { render json: autolist }
    end
  end

end
