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
					post :upload_icon
				end
				member do
					post :favorite
					post :report
					post :block
				end
			end
			resources :foot_prints, only: [:create] do
				collection do
					get :mine_to
					get :mine_from
				end
			end
		end
	end
end
