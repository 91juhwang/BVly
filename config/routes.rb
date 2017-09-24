Rails.application.routes.draw do
  devise_for :users
  resources :urls
  root to: 'welcome#index'
  get '/:id', to: 'urls#redirect', as: 'redirect_original'
end
