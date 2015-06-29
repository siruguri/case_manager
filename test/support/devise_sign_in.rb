def devise_sign_in(u)
  @request.env["devise.mapping"] = Devise.mappings[:user]
  sign_in u
end

def devise_sign_out(u)
  sign_out u
end
