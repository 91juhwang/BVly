Rails.application.routes.draw do
  root to: 'welcome#index'
  devise_for :users
  resource :users, only: [:show] do
    resources :user_urls, only: [:create]
  end
  resources :urls, only: [:index, :create]
  get '/:id', to: 'urls#redirect', as: 'redirect_original'
end
