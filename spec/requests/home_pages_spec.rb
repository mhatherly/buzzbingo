require 'spec_helper'


describe "Home Page" do
   subject {page}
  before(:each) {visit root_path}

   describe "has the standard features of this app's pages" do
    # do I need to get more specific on where the source is?
      it "has a logo" do 
        #page.should have_xpath("//img[(@id = 'logo_image') and (@src = '/assets/bblogo.png')]")
         #page.should have_xpath("//div[@id='logo']/img") # has an image in div logo
         page.should have_xpath(
           "//div[@id='logo']/img[(@id = 'logo_image') and (@src = '/assets/bblogo.png')]"
           )
      end
     
       

       
     #it { should have_content("have title") } # fix this  
   end
    
    #describe "has a narrative"  do
      #it should { pending("intro to app")}
    #end
    
    #describe "it should have a link to the help page" do
       #it { should have_link("Help",  href: help_path) } 
    #end
    
    #describe "it should have a link to the maintain buzzwords page" do
       #it { should have_link("Buzzword",  href: buzzword_path) } 
    #end 
     
     #describe "it should have a button to generate a bingo page" do
        #it { should have_selector('input', value: 'Generate') }
     #end 
     
     #describe "it should have a link to the Tech Info page" do
        #it { should have_link("Buzzword",  href: tech_path ) } 
     #end   
           
              
end
