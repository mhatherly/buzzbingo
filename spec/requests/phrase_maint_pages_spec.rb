require 'spec_helper'

describe "Buzzwords Maint  pages" do
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
     page.should  have_link("New Buzzword", href: new_buzzword_path) 
  end
  
  it "does other stuff" do
      pending "next steps"
  end
  
 end # listing page 
 describe "Buzzword Add Page"  do
   before do
    visit(new_buzzword_path) 
   end
   
   let(:submit) { "Create Buzzword" }
   
    describe "has the standard features of this app's pages" do
      it_behaves_like "Standard_Web_Page"
    end
   
   describe "has a meaningful heading" do
     it "such as New Buzzword" do
       page.should have_css('h1', text: "New buzzword") 
     end
   end
   
   describe "does not allow duplicates"  do
        
           dup_phrase = "To be duplicated" 
            let!(:buzzword_orig)  { FactoryGirl.create(:buzzword, phrase: dup_phrase) } 
           before do
             
             #let!(:buzzword) { FactoryGirl.create(:buzzword, phrase: "Lorem Ipsum") }
           end  
          	it "a buzzword is not created if duplicate" do
                fill_in "Phrase",  with: dup_phrase
                expect { click_button submit }.not_to change(Buzzword, :count)  
            end
            describe "after submission" do
                before do 
                  fill_in "Phrase",  with: dup_phrase
                  click_button submit 
                end
                it "should be on the 'new' page" do
                    page.should have_content('New buzzword')
                end  # right page
                it "should have an error message of some sort" do
                page.should have_content('error')
                end
                it "should have the correct error message" do
                    page.should have_error_message("Phrase has already been taken") 
                end
        end #after sub
   end  
   
   describe "does not allow blanks"  do
     	it "a buzzword is not created if blank" do
			expect { click_button submit }.not_to change(Buzzword, :count)  
		end
		describe "after submission" do
			before { click_button submit }
			it "is on the 'new' page" do
              page.should have_content('New buzzword')
            end  # right page
			it "has an error message of some sort" do
              page.should have_content('error')
            end  #error msg
			it "has the correct error message" do
              page.should have_error_message("Phrase can't be blank") 
            end # correct err
        end #after sub
   end  #does not allow blanks
   
   it "does not allow messages that are too long "  do 
      pending "test too long"
  end
   
 end # Add page   

end
