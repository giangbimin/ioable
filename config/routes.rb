Rails.application.routes.draw do
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end
  root to: 'articles#index'
  resources :articles, concerns: :paginatable
  resources :tags, only: :show
  get '*path' => redirect('/')
end
