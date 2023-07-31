Rails.application.routes.draw do
  root "main_pages#index"

  get 'main_pages/index'
  get 'main_pages/help'
  get 'main_pages/info'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  post "/import" => "users/registrations#import", :as => :import

  # resources :groups do
  #   resources :users
  # end

  resources :groups
  resources :users
  resources :books do
    get :preview_book, on: :member
  end
  resources :contact_form_registration, only: %i[new create]
  resources :contact_form_qa, only: %i[new create]
  resources :categories do
    get :filter, on: :member
  end

  mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdf_view'
end
