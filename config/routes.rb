Rails.application.routes.draw do
  root 'users#index'

  resources :users
  resource :session, only: %i[new create destroy]
  resources :questions, except: %i[:show new index]
  # param: :text меняет путь с id на text -- /hashtags/:text
  resources :hashtags, only: :show, param: :text
end
