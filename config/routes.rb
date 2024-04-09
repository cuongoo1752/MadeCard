Rails.application.routes.draw do
  resources :fix_pictures, except: [:show] do
    collection do
      get 'list_image', to: 'fix_pictures#list_image'
    end
  end

  resources :wishes, only: [:index] do
    collection do
      post 'update_all', to: 'wishes#update_all'
    end
  end
  resources :categories, only: [:index] do
    collection do
      post 'update_all', to: 'categories#update_all'
    end
  end
  resources :events, only: [:index] do
    collection do
      get 'list_wishes', to: 'events#list_wishes'
      post 'update_all', to: 'events#update_all'
    end
  end
  resources :texts
  resources :images
  resources :layers_on_cards
  resources :cards do
    collection do
      get 'design', to: 'cards#design'
      post 'create_card_and_layers', to: 'cards#create_card_and_layers'
    end
  end
  devise_for :users
  resources :users
  root 'cards#design'
end
