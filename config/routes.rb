Buzzbingo::Application.routes.draw do
  resources :buzzwords, only: [:create, :index, :new, 
                        :edit, :update, :destroy]

  root to: 'home#home'
   
   match '/home', to: 'home#home'
   match '/tech', to: 'tech#tech'
   match '/help', to: 'help#help'
end
