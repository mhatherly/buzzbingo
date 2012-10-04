require 'spec_helper'


describe "Home Page" do
   subject {page}
  before(:each) {visit root_path}

   describe "has the standard features of this app's pages" do
      it_behaves_like "Standard_Web_Page"
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
