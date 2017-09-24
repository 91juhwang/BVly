Rails.application.routes.draw do
  root to: 'welcome#index'
  devise_for :users
  resources :urls, only: [:index, :create]
  get '/:id', to: 'urls#redirect', as: 'redirect_original'
end
