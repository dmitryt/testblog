Easyblog::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :posts do
    resources :comments, except: [:show, :index] do
      get :vote_up
      get :vote_down
      get :reset_abusing
    end
    member do
      post :mark_archived
    end
  end
end
