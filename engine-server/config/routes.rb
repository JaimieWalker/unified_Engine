Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
  mount ActionCable.server => '/g_cable'
  mount ActionCable.server => '/k_cable'
  mount ActionCable.server => '/c_cable'
  get 'products', to: 'product#get_products'
  get 'recent', to: 'product#recent'
end
