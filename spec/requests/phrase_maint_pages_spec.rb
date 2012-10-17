require 'spec_helper'

describe "Buzzwords Maint  pages" do
  # This parameter might change as I refine, so I will parametize it
  # The max length of a buzzword phrase
  max_length = 66
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
   # here are some things that I might want to design away
   # so I will parameteritize them
   page_id_string = "New buzzword"
   page_id_css_tag = "h1"
   
   before do
    visit(new_buzzword_path) 
   end
   
   let(:submit) { "Create Buzzword" }
   
   describe "has the standard features of this app's pages" do
     it_behaves_like "Standard_Web_Page"
    end
   
   describe "has a meaningful heading" do
     it "such as #{page_id_string}" do
       page.should have_css(page_id_css_tag, text: page_id_string) 
     end
   end
   
   describe "does not allow duplicates"  do
     dup_phrase = "To be duplicated" 
     let!(:buzzword_orig)  { FactoryGirl.create(:buzzword, phrase: dup_phrase) } 
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
        page.should have_css(page_id_css_tag, text: page_id_string)
      end  # right page
      
      it "should have an error message of some sort" do
       page.should have_content('error')
      end
      
      it "should have the correct error message" do
        page.should have_error_message("Phrase has already been taken") 
      end
    end #after sub
   end  #does not allow duplicates
   
   describe "does not allow blanks"  do
    it "a buzzword is not created if blank" do
     expect { click_button submit }.not_to change(Buzzword, :count)  
    end
    describe "after submission" do
     before { click_button submit }
     it "is on the Add Buzzword page" do
      page.should have_css(page_id_css_tag, text: page_id_string)
     end  # right page
     it "has an error message of some sort" do
      page.should have_content('error')
     end  #error msg
     it "has the correct error message" do
       page.should have_error_message("Phrase can't be blank") 
     end # correct err
    end #after submission
   end  #does not allow blanks
   
   describe "does not allow messages that are too long "  do 
    before do
     fill_in :phrase,  with: "a" * (max_length + 1)
    end
    it "a buzzword is not created if too long" do
     expect { click_button submit }.not_to change(Buzzword, :count)  
    end
    describe "after submission" do
     before { click_button submit }
     it "should be on the 'new' page" do
        page.should have_css(page_id_css_tag, text: page_id_string)
      end  # right page
     it "has an error message of some sort" do
      page.should have_content('error')
     end  #error msg
     it "has the correct error message" do
       page.should have_error_message("Phrase is too long") 
     end # correct err
    end #after sub
   end # does not allow 

   describe "does allow messages that are at Maximum length "  do 
    before do
       fill_in :phrase,  with: "a" * (max_length)
    end
    it "a buzzword is created if phrase is max length" do
      expect { click_button submit }.to change(Buzzword, :count)  
    end
   end # does allow  
  end # Add page   
 
 
describe "Buzzword Edit Page"  do
   let!(:buzzword)  { FactoryGirl.create(:buzzword, 
                      phrase: "Lorem Ipsom",  
                      updated_at: 10.minutes.ago) } 
   let(:submit) { "Update Buzzword" }
   before do
     visit(edit_buzzword_path(buzzword)) 
   end
   
   describe "has the standard features of this app's pages" do
      it_behaves_like "Standard_Web_Page"
    end
   
   describe "has a meaningful heading" do
     it "such as Editing Buzzword" do
       page.should have_css('h1', text: "Editing buzzword") 
     end
   end
   
   describe "does not allow duplicates"  do
        
           dup_phrase = "To be duplicated" 
            let!(:buzzword_orig)  { FactoryGirl.create(:buzzword, 
                                          phrase: dup_phrase,
                                          updated_at: 10.minutes.ago) } 

          	it "a buzzword is not updated if duplicate" do
                fill_in "Phrase",  with: dup_phrase
                expect { click_button submit }.not_to change{
                   Buzzword.find_by_id(buzzword_orig).updated_at 
                 }
            end
            describe "after submission" do
                before do 
                  fill_in "Phrase",  with: dup_phrase
                  click_button submit 
                end
                it "should be on the 'Edit' page" do
                    page.should have_content('Editing buzzword')
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
     	before {fill_in :phrase, with: nil}
        it "a buzzword is not updated if blank" do
            
            expect { click_button submit }.not_to change{
                 Buzzword.find_by_id(buzzword).updated_at } 
 		end
		describe "after submission" do
			before { click_button submit }
			it "is on the 'Editing' page" do
              page.should have_content('Editing buzzword')
            end  # right page
			it "has an error message of some sort" do
              page.should have_content('error')
            end  #error msg
			it "has the correct error message" do
              page.should have_error_message("Phrase can't be blank") 
            end # correct err msg
        end #after sub
   end  #does not allow blanks
   
   describe "does not allow phrases that are too long "  do 
      max_length = 66
      before do
        fill_in :phrase,  with: "a" * (max_length + 1)
      end
      it "a buzzword is not updated if too long" do
            expect { click_button submit }.not_to change{
                 Buzzword.find_by_id(buzzword).updated_at }
		end
		describe "after submission" do
			before { click_button submit }
			it "is on the 'Update' page" do
              page.should have_content('Editing buzzword')
            end  # right page
			it "has an error message of some sort" do
              page.should have_content('error')
            end  #error msg
			it "has the correct error message" do
              page.should have_error_message("Phrase is too long") 
            end # correct err
        end #after sub
  end # does not allow 

   describe "does allow phrases at maximum length "  do 
      max_length = 66
      before do
        fill_in :phrase,  with: "a" * (max_length)
      end
      it "a buzzword is updated if phrase is max length" do
			expect { click_button submit }.to change{
                 Buzzword.find_by_id(buzzword).updated_at }  
      end
    end # does allow  
 end # Edit page 
end
