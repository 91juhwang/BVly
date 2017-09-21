Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :urls
  get '/:url_id', to: 'urls#redirect', as: 'redirect_original'
end
