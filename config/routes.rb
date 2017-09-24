Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/:id', to: 'urls#redirect', as: 'redirect_original'
  resources :urls
end
