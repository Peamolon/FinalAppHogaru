Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
 devise_for :users
devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
end
  get '/list_by_date/date', to: 'reports#list_by_date'
  get '/graphic/date', to: 'reports#graphic'
  get '/filter_date', to: 'reports#filter_date'
  resources :reports
  root 'reports#home'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
