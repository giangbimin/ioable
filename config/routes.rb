Rails.application.routes.draw do
  devise_for :users
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end
  root to: 'articles#index'
  resources :articles, concerns: :paginatable do
    resources :comments
  end
  resources :authors
  resources :tags, only: :show
  # get '*path' => redirect('/')
  get '/*page' => 'pages#show'
end
