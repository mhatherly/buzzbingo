require 'spec_helper'

describe "Buzzwords pages" do
  subject {page}
   let!(:buzzword) { FactoryGirl.create(:buzzword, phrase: "Lorem Ipsum") }
   
  before(:each) { visit buzzwords_path }
  
  describe "has the standard features of this app's pages" do
      it_behaves_like "Standard_Web_Page"
  end
     
  describe "Listing Page" do
     
 
    it "does not have a show link" do
     page.should have_content(buzzword.phrase) 
      page.should_not have_link("Show")  
    end 
  pending ("does other stuff")
  end
end
