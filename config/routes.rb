Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
		namespace :v1 do
			resources :users, only: [:index, :show] do
				collection do
					post :sign_up
					post :sign_in
					post :delete
					post :update_last_login
					get :search
					get :mutual_friend
				end
				member do
					post :favorite
					post :report
					post :block
				end
			end
		end
	end
end
