require 'spec_helper'

describe "Help page" do
  subject {page}
  before(:each) { visit help_path }
  
  describe "has the standard features of this app's pages" do
      it_behaves_like "Standard_Web_Page"
    end
   it "has help for the menu options" do  
     page.should have_content("Options on the Menu Bar ")
     page.should have_content("Maintaining Buzzwords")
   end
   it "has help for Maintenance" do  
    page.should have_content("Maintaining Buzzwords")
  end
  
end
