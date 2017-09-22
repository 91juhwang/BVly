Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :urls
  get '/:id', to: 'urls#redirect', as: 'redirect_original'
end
