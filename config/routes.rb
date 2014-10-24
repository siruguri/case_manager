require 'resque_web'

ResqueWeb::Engine.eager_load!
CaseManager::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin_interface', as: 'rails_admin'

  # I like having this to populate the navbar with, via the database rather than do it in the views.
  resources :navbar_entries

  # Case Management
  resources :form_entries
  resources :clients
  resources :field_notes

  # Open Referral
  resources :organizations
  get 'search_organizations' => 'organizations#search'
  
  # Logins and Profiles
  devise_for :users
  resources :users, path: 'profiles'

  # Routes for my own profile
  get '/profile' => 'profiles#show'

  get '/' => 'welcome#home'
  root to: 'welcome#home'

  constraints(format: /json/) do
    namespace :api, defaults: {format: 'json'} do
      namespace :v1 do
         get '/clients' => 'clients#search'
        post '/client/:id' => 'clients#update'
        post '/clients' => 'clients#update'
        post '/profile/:cmd(.:format)' => 'profiles#process_cmd'
      end
    end
  end

  resque_web_constraint = lambda do |request|
    current_user = request.env['warden'].user
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
