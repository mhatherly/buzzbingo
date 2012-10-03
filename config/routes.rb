Buzzbingo::Application.routes.draw do
  root to: 'home#home'
   
   match '/home', to: 'home#home'
   match '/tech', to: 'tech#tech'
   match '/help', to: 'help#help'
end
