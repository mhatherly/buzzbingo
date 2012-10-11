require 'spec_helper'

describe "Buzzwords pages" do
 describe "Listing page" do 
  subject {page}
   let!(:buzzword) { FactoryGirl.create(:buzzword, phrase: "Lorem Ipsum") }
   
  before(:each) { visit buzzwords_path }
  
  describe "has the standard features of this app's pages" do
      it_behaves_like "Standard_Web_Page"
  end
  it "does not have a show link" do
    page.should have_content(buzzword.phrase) 
    page.should_not have_link("Show")  
  end 
  
  it "has a method to edit phrases" do
     
     edit_xpath = '//a[@href="' + 
                   edit_buzzword_path(buzzword) + 
                   '"]/i[@class="icon-pencil"]'
     page.should have_xpath(edit_xpath)
  end  
   
  it "has a method to destroy phrases" do
     destroy_xpath = '//a[@href="' + 
                   buzzword_path(buzzword) + 
                   '"]/i[@class="icon-trash"]'
     page.should have_xpath(destroy_xpath)
  end   
  
  it "has a method to add phrases" do
     page.should  have_link("New", href: new_buzzword_path) 
  end
  
  it "does other stuff" do
      pending "next steps"
  end
  
   end # listing page 
end
