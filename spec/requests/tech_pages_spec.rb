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
        it "links to Rails official site" do
           page.should have_link(
            "Ruby on Rails", 
            href: "http://rubyonrails.org/" )
        end  
         it "links to Ruby official site" do
           page.should have_link(
            "Ruby", 
            href: "http://www.ruby-lang.org/en/" )
        end  
         it "Credits Linus and team" do
           page.should have_link(
            "Linux", 
            href: "http://www.kernel.org" )
        end  
        it "lists gems used" do
           page.should have_content("Gems")
        end
        
       
    end # gives credit 

    describe "has a section on future likely technology to be used" do
     it "has a discussion on guard gem" do
           page.should have_content("guard")
     end
    end
    
    describe "has a list of future development paths" do
     it "has a Roadmap section" do
           page.should have_selector("h3", text: "Roadmap")
     end
    end
end    
    
    
  
     
   
