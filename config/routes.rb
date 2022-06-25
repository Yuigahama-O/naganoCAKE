Rails.application.routes.draw do
  devise_for :admins, controllers: {
  sessions: 'admins/sessions'
}
  devise_for :customers
  namespace :admin do
    resources :genres, only: [:index, :edit, :update, :create]

    resources :items, only: [:new, :index, :show, :edit, :create, :update]

    resources :orders, only: [:index, :show, :update]

    resources :order_details, only: [:update]

    resources :customers, only: [:index, :show, :edit, :update]
  end


  namespace :public do
    delete 'cart_items/destroy_all'
    resources :cart_items, only: [:index, :create, :destroy, :update]


    resources :items, only: [:index, :show]

    post 'orders/confirm'
    get 'orders/complete'
    resources :orders, only: [:new, :index, :show, :create]


    resources :deliveries, only: [:index, :edit, :update, :create, :destroy]

    get 'customers/confirm'
    # patch 'customers/withdraw' => 'customers#withdraw' , as: 'withdraw'
    resources :customers, only: [:show, :edit, :update] do
      collection do
      patch :withdraw
      end
    end



  end
    root to: 'homes#top'
    get 'homes/about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
