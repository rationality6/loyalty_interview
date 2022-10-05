Rails.application.routes.draw do
  devise_for :users
  scope module: :api, path: '/api' do
    scope module: :v1, path: '/v1' do
      resources :purchase_transactions do
        collection do
          post :purchase
        end
      end
    end
  end

end
