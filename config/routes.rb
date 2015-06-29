CaseManager::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin_interface', as: 'rails_admin'

  # I like having this to populate the navbar with, via the database rather than do it in the views.
  resources :navbar_entries
  resources :appointment_requests, only: [:new, :create, :show]
  
  # Case Management
  resources :clients
  
  # Open Referral
  resources :organizations
  get 'search_organizations' => 'organizations#search'
  
  # Logins and Profiles
  devise_for :users
  resource :profile

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

  get "run_alert" => "alerts#run_alert"

  # Need a catch all to redirect to the errors controller, for catching 404s as an exception
  match "*path", to: "errors#catch_404", via: [:get, :post]
end
