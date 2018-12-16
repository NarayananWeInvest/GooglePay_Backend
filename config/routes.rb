Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :rules
    end
  end

  namespace :api do
    namespace :v1 do
	     resources :users do
  		    resources :bank_accounts do
  			    resources :transactions, only: [:show, :index]
  		    end
        end
      end
  	end

    namespace :api do
      namespace :v1 do
        resources :transactions, only: [:create, :update, :destroy] do 
    	     resources :scratch_cards
        end
      end
    end

    #resources :rules

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
