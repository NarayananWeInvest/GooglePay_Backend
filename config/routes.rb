Rails.application.routes.draw do
  
  resources :rules
	resources :users do
  		resources :bank_accounts do
  			resources :transactions, only: [:show, :index]
  		end
  	end
    resources :transactions, only: [:create, :update, :destroy] do 
    	resources :scratch_cards
    end

    resources :rules

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
