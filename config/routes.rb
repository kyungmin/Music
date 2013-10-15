Music::Application.routes.draw do
  resources :users do
    resources :tracks, :only => [:create, :new, :destroy]
    get 'activate', on: :member
  end
  resource :session, :only => [:create, :new, :destroy]
  resources :bands do
    resources :albums, :only => [:index, :new, :create, :destroy]
  end
  resources :albums, :only => [:show] do
    resources :tracks, :only => [:create, :new, :destroy, :show]
  end

  resources :notes, :only => [:create, :destroy]
end
