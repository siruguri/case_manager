class OrganizationsController < ApplicationController

  def search
    q = params[:q]
    
    @results = Organization.search q
    puts ">>> found #{@results.count} results"
  end

end
