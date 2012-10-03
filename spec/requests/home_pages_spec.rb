require 'spec_helper'


describe "Home Page" do
   subject {page}
  before(:each) {visit root_path}

   describe "has the standard features of this app's pages" do
      
      it "has a title"  do
        page.should have_selector('title', text: "Buzzword Bingo") 
      end
      
      
      it "has a logo" do 
         page.should have_xpath(
           "//div[@id='logo']/img[(@id = 'logo_image') and (@src = '/assets/bblogo.png')]"
           )
      end
        
      describe "with a navigation bar" do
         #it "that points to the Buzzword maint page" do
           #page.should have_link("buzzwords", href: buzzwords_path)
        #end
        
        
        it "that points to the Tech Info page" do
           page.should have_link('Tech Info', href: tech_path)
                  
        end
        
        it "that points to the Help page" do
           page.should have_link('Help', href: help_path)
                  
        end
       end  #nav bar
       
       
       
   end
    
    describe "has a narrative"  do
      it "with a friendly description"  do
       page.should have_content("The concept of this application")
      end
    end
    
  
     
    describe "has a button to generate a bingo card" do
        it { should have_link('Give me a Bingo Card!') }
     end 
     
     #describe "it should have a link to the Tech Info page" do
        #it { should have_link("Buzzword",  href: tech_path ) } 
     #end   
           
              
end
