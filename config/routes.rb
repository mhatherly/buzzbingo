Buzzbingo::Application.routes.draw do
  
  resources :buzzwords, except: :show 

  root to: 'home#home'
   match '/puzzle',  to: 'puzzle#puzzle'
   match '/home', to: 'home#home'
   match '/tech', to: 'tech#tech'
   match '/help', to: 'help#help'
end
