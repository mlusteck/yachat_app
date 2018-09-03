Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :rooms do
    resources :messages
  end

  root 'simple_pages#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
