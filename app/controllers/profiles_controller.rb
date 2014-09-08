class ProfilesController < ApplicationController

  def show
    # Be logged in
    if current_user.nil?
      raise Errors::NeedsSignInException
    end
  end

end
