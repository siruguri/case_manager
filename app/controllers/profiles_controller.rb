class ProfilesController < ApplicationController

  def show
    # Be logged in
    if current_user.nil?
      raise Errors::NeedsSignInException
    end

    @user = current_user
  end

end
