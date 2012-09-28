require 'acceptance/acceptance_helper'

feature 'Help Screen', %q{
  In order to get information about how to use the app
  As a user
  I want to see a help screen
} do

  scenario 'user navigates to help screen' do
    
    subject { page }
    
    visit "http://localhost:3003" 
   
    page.should look_like_all_pages()
    page.should have_content("Help") 
  end 

end
