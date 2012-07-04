Aa::Application.routes.draw do

    resource :user_session, :only => :create

    root :to => 'home#index'

    match '/login'  => 'user_sessions#new',     :as => :login
    match '/logout' => 'user_sessions#destroy', :as => :logout

end