require 'spec_helper'


describe "Tech Info Page" do
   subject {page}
  before(:each) {visit tech_path}

   describe "has the standard features of this app's pages" do
      it_behaves_like "Standard_Web_Page"
    end
    
    describe "gives credit where credit is due" do 
       it  "links to Micheal Hartl's tutorial" do
        page.should have_link(
            "Ruby on Rails Tutorial", 
            href: "http://www.railstutorial.org" )
      end  
      
    pending "lists gems used"
    pending "discusses guard"
    pending "credits ruby and rails"
    pending "credits linus and team"
    end 
end    
    
    
  
     
   
