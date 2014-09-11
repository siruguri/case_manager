require 'resque_web'

ResqueWeb::Engine.eager_load!
CaseManager::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin_interface', as: 'rails_admin'

  # I like having this to populate the navbar with, via the database rather than do it in the views.
  resources :navbar_entries

  resources :form_entries
  resources :clients

  # Logins and Profiles
  devise_for :users
  resources :users, path: 'profiles'

  # Routes for my own profile
  get '/profile' => 'profiles#show'

  root to: 'welcome#home' # Change this to something else in your app.

  constraints(format: /json/) do
    namespace :api, defaults: {format: 'json'} do
      namespace :v1 do
        get '/clients' => 'clients#search'
        post '/profile/:cmd(.:format)' => 'profiles#process_cmd'
      end
    end
  end

  resque_web_constraint = lambda do |request|
    current_user = request.env['warden'].user
    puts ">>> Checking user for admin: #{current_user.is_admin?}" unless current_user.nil?
    !(current_user.nil?) && current_user.is_admin?
  end

  constraints resque_web_constraint do
    mount ResqueWeb::Engine => "/jobs_list"
  end

  get "run_alert" => "alerts#run_alert"

  # The rest of the routes file is probably useless to most new apps based on this template, EXCEPT for the 
  # 404 catchall below which has to always be at the end.

  # Need a catch all to redirect to the errors controller, for catching 404s as an exception
  # match "*path", to: "errors#catch_404", via: [:get, :post]

end
