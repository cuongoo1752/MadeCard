Rails.application.routes.draw do
  resources :wishes
  resources :categories
  resources :events do
    collection do
      get 'list_wishes', to: 'events#list_wishes'
    end
  end
  resources :texts
  resources :images
  resources :layers_on_cards
  resources :cards do
    collection do
      get 'design', to: 'cards#design'
    end
  end
  resources :users
end
