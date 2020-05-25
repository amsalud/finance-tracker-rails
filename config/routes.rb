Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'my-portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#search'
  post 'add_to_portfolio', to: 'stocks#add_to_portfolio'
  delete 'remove_from_portfolio', to: 'stocks#remove_from_portfolio'
  get 'friends', to: 'friendship#index'

end
