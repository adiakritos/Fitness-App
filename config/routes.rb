GetJoocy::Application.routes.draw do

  resources :foods

  resources :search_foods

  root "static_pages#frontpage"

  devise_for :trainers

  devise_scope :trainer do
    get  "/login"  => "devise/sessions#new"
    get  "/logout" => "devise/sessions#destroy"
    get  "/signup" => "devise/registrations#new"
  end

  get "/settings",  to: 'static_pages#settings'
  get "/optin",     to: 'static_pages#optin'
  get "/faq",       to: 'static_pages#faq'

  resources :foods do
    collection do
      post :search
      post :import
    end
  end

  resources :global_foods do
    collection do
      post :import
      post :search
    end
  end

  resources :meal_foods
  resources :meals
  resources :recipes,        only: [:index]
  resources :status_updates, only: [:index, :show, :create, :destroy]
  resources :clients,        only: [:index, :show, :create, :update]

end
