Rails.application.routes.draw do
  root 'conversations#index'

  resources :stopwords, only: %i[new index create]
  resources :conversations, only: %i[index new create]

  get 'search', to: 'conversations#search'
end
