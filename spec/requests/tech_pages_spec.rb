require 'spec_helper'


describe "Tech Info Page" do
   subject {page}
  before(:each) {visit tech_path}

   describe "has the standard features of this app's pages" do
      it_behaves_like "Standard_Web_Page"
    end
    
    describe "has something else"
    pending "I have to think"
end    
    
    
  
     
   
