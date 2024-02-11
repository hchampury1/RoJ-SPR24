# Project name: ACCR Mail Manager
# Description: Mail database and management system for ACCR community partner
# Filename: routes.rb
# Description: Configuration file for Rails page routes
# Last modified on: 4/8/22
# Code written by Team 13, Team 14, and Team 24

# Project name: AMSTR
# Description: ACCR Management System Tracker
# Filename: routes.rb
# Description: Configuration file for actions/routes of user options
# Last modified on: 4/13/22

# frozen_string_literal: true


# frozen_string_literal: true
# This file tells the Rails server how incoming requests are sent to which
# controller and method.
#
#
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do


  post 'speaker/show'
  post 'webinars/deregisterSubmitted'
  get 'webinars/deregisterSubmitted'
  get 'speaker/new'
  post 'speaker/created'

  get 'requests/viewrequests'
  get 'webinars/deregister'
  

  resources :requests

  get 'webinars/exportCSV'
  post 'webinars/exportCSV'

  get 'charges/new'
  get 'charges/create'
  post 'exportCSV', to: 'webinars#exportCSV', as: 'exportCSV'

# delete from here if problem 

  resources :donors
  resources :donars
  get 'in_kinds_home/index'
  get 'inkinds/index'
  
  resources :inkinds  do
    collection do
      get 'download_pdf'
    end
  end

  # ...

  #pro-bono donations
  get '/donations.csv' => 'donations#index'
  match 'donations', to: 'donations#donations', via: 'get'
  resources :donations

  resources :event_details
  get 'calendar/calendar'

# to here

  resources :registrants
  resources :responses
  resources :reminders
  resources :webinars do
    member do
      get :registrants
    end
  end
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get 'webinars/index'
  get 'webinars/about'
  # does not need devise login
  # get 'webinarjoin', to: "webinarjoin#index"
  

  # routes for speaker information page
  get 'speaker/index'

  # The root page is set for the index.
  ### root 'home#index'
  get 'mail_manager_home/index'

  # Routes for pages other than the root.
  get 'mail_manager_home/about'

  # All pages associated with mail_entries and tags scaffold.
  resources :mail_entries
  resources :tags
  
  # Devise authentification pages. This controlls the user login
  # and authentification system.
  devise_for :users, :controllers => {:registrations => "users/registrations"}

  # Custom routes for adding / deleting tags en masse.
  post 'delete_selected' => 'tags#delete_selected'
  post 'create_entered' => 'tags#create_entered'
  # post 'tag_filter' => 'mail_entries#'


  get 'statistics/index'
  resources :worklogs
  resources :projects

  resources :searches do
    get "search", on: :collection
  end

  root 'nav#home'

  get 'dashboard/dash'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  get 'dashboard/dash'
  get 'dashboard/view_report'
  get 'home/index'
  get 'report/index'
  get 'dashboard/aboutus'

  
  # The root page, e.g. www.example.com/, is sent here
  # root 'controller#method_in_controller'
  post "/map/index" => "map#index"
  # root 'home#index'
  get 'mapping_justice_home/index'
  get 'map/graph'
  get 'map/index'
  get 'about/index'
  get 'upload/index'
  post 'upload/uploadcsv'
  get 'upload/downloadcsv'
  get 'upload/edit'
  post 'upload/update'
  patch 'upload/:format', to: 'upload#update'
  get 'upload/destroy'
  #patch 'upload/:format', to: 'upload#destroy'

  #Used for clearing sorting
  get "/donations/clear_sort", to: "donations#clear_sort", as: "clear_sort"
  
  get "/donations/filtering", to: "donations#filtering", as: "filtering"

  get 'in_kinds_home/index'
  get 'donors/index'
  # Used for webinar registration forms
  get 'registrants/new' # Links to form input page
  get 'registrants/index'
  post 'registrants/new', to: 'registrants#create' # Creates post route for submitting form
  patch 'registrants/:id/activate',to:'registrants#activate' , as: :activate
  patch 'registrants/:id/deactivate',to:'registrants#deactivate' ,as: :deactivate
  # Devise authentification pages. This controlls the user login
  # and authentification system.

  # commented out due to rake aborted error
  # devise_for :users

  # The root page, e.g. www.example.com/, is sent here
  # root 'controller#method_in_controller'
  #root 'home#index'
  
  # devise_scope :user do
  #   root 'devise/sessions#new'
  # end
  
  # Examples:
  #
  # # Add app CRUD operations from a controller. Used with scaffolding.
  # # CRUD -> create (API/POST), new (page/GET), index, show,
  #           edit(page/GET), update(API/PATCH|PUT), destroy(API/DELETE)
  # resources :my_controller
  #
  # # Add GET path for photos controller, index method
  # get 'photos/index'
  #
  # # Resources, but only register these methods
  # resources :photos, only: [:index, :new, :create, :destroy]
  #
  # # Add PUT path for the given url, but send it to a different controller
  # # than rails would assume by the name. to: 'controller#method_name'.
  # # It would have extected to: 'add_tags#add', which would fail
  # put '/add_tags/add', to: 'users#add_tags'

  # stripe
  resources :charges, only: [:new, :create, :thanks]
  get 'thanks', to: 'charges#thanks', as: 'thanks'
end

