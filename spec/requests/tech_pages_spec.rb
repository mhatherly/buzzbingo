require 'spec_helper'


describe "Tech Info Page" do
   subject {page}
  before(:each) {visit tech_path}

   describe "has the standard features of this app's pages" do
      it_behaves_like "Standard_Web_Page"
    end
    
    describe "gives credit where credit it due"
    pending "links to Hartl's tutorial"
    pending "lists gems used"
    pending "discusses guard"
    pending "credits ruby and rails"
    pending "credits linus and team"
    
end    
    
    
  
     
   
