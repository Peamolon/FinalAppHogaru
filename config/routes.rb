Rails.application.routes.draw do
  resources :progresses
  get 'email_links/new'
  
  post 'reports/createShare', as: :share_link
  
  get '/last_days', to: 'reports#last_days'
  #post 'email_links/create', as: :magic_link
  #get 'email_link/validate', as: :email_link
  post 'reports/share', as: :magic_link
  
  get '/goals', to: 'reports#goal'
  
  get '/share_graphic', to: 'reports#share_graphic'
  get 'password_resets/new'
  get 'password_resets/edit'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get '/share', to: 'reports#share'
  get '/list_by_date/date', to: 'reports#list_by_date'
  get '/graphic/date', to: 'reports#graphic'
  get '/filter_date', to: 'reports#filter_date'
  resources :reports
  root 'reports#home'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
