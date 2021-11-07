Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#splash'

  resources :learning_items, except: :show
  get '/dashboard', to: 'learning_items#index', as: :dashboard
  put '/mark_as_learned', to: 'learning_items#toggle_mark_as_learned', as: :toggle_mark_as_learned
end
