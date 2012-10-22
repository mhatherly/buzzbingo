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
  describe "displays the buzzwords" do
   it "has the created buzzword" do
      page.should have_content(buzzword.phrase)
    end
    describe "shows buzzwords in alphabetical order"  do
      let!(:firstbuzz) { FactoryGirl.create(:buzzword, phrase: "AAAA")}
      before {visit buzzwords_path}
      describe "the test phrases are in the correct order" do
        data_table_xpath = '//table[@id="buzztable"]'
        # first tr will have header so we do second and third
        
        
        it "with the AAAA buzzword in the first row"  do
             data_row_xpath_1stlinephrase = data_table_xpath +                 
                '//tr[2]/td//text()[contains(.,"'+ firstbuzz.phrase + '")]'
            page.should have_xpath(data_row_xpath_1stlinephrase)
        end
        it "with the standard phrase in the second row"  do
           data_row_xpath_2ndlinephrase = data_table_xpath + 
                   '//tr[3]/td//text()[contains(.,"'+ buzzword.phrase + '")]'
         
         page.should have_xpath(data_row_xpath_2ndlinephrase)  
        end
       
       
      end  
    
    end
   end 
  
  it "does not have a show link" do
     
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
  
  describe "has pagination" do
     
     before do 
     # create enough  buzzwords to only fill the page
        9.times  do |i|
          FactoryGirl.create(:buzzword, phrase: "test phrase #{i +1}") 
          visit(buzzwords_path) 
        end 
     end
     it "does not paginate at 10 records" do
        test_href = buzzwords_path + '?page=2'
        page.should_not have_link("2", href: test_href)
     end
     
     describe "does paginate at 11 records" do
       before  do
         FactoryGirl.create(:buzzword, phrase: "zzz phrase 10")
          visit(buzzwords_path) 
       end  
        it "has a link to page 2" do
          test_href = buzzwords_path + '?page=2'
          page.should have_link("2", href: test_href)
        end
      end
  end
  describe "does deletes" do
    let!(:buzz2) { FactoryGirl.create(:buzzword,phrase: "Delete this one") }  
    before {visit buzzwords_path}
    it "destroys records" do
     destroy_xpath = '//a[@href="' + 
               Rails.application.routes.url_helpers.buzzword_path(buzz2) + 
               '"]/i[@class="icon-trash"]/..' 
               # the trailing /.. selects the attribute rather than the icon
    
     page.should have_xpath(destroy_xpath)   
    
     expect{
      find(:xpath, destroy_xpath).click}.to change(Buzzword, :count).by(-1)
    end
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
      puts :page_id_string
     it ("such as #{page_id_string}" )  do
       page.should have_css(page_id_css_tag, text: page_id_string) 
     end
   end
   
   describe "does not allow duplicates"  do
    dup_phrase = "To be duplicated" 
    let!(:buzzword_orig)  { FactoryGirl.create(:buzzword, 
                                               phrase: dup_phrase) }
    before { fill_in "Phrase",  with: dup_phrase }                                          
    it "a buzzword is not created if duplicate" do
       expect { click_button submit }.not_to change(Buzzword, :count)  
    end
    it_should_behave_like "maint_page_with_error", page_id_css_tag,
                                                  page_id_string,
                                    "Phrase has already been taken"
  
   end  #does not allow duplicates
   
   describe "does not allow blanks"  do
    it "a buzzword is not created if blank" do
     expect { click_button submit }.not_to change(Buzzword, :count)  
    end
     it_should_behave_like "maint_page_with_error", page_id_css_tag,
                                                  page_id_string,
                                                "Phrase can't be blank" 
     end  #does not allow blanks
   
   describe "does not allow messages that are too long "  do 
    before do
     fill_in :phrase,  with: "a" * (max_length + 1)
    end
    it "a buzzword is not created if too long" do
     expect { click_button submit }.not_to change(Buzzword, :count)  
    end
    it_should_behave_like "maint_page_with_error", page_id_css_tag,
                                                  page_id_string,
                                                "Phrase is too long" 
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
   
    page_id_string = "Editing buzzword"
    page_id_css_tag = "h1"
   
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
      it "such as #{page_id_string }" do
       page.should have_css(page_id_css_tag, text: page_id_string ) 
      end
    end
   
    describe "does not allow duplicates"  do
    
      dup_phrase = "To be duplicated" 
      let!(:buzzword_orig)  { FactoryGirl.create(:buzzword, 
                                          phrase: dup_phrase,
                                          updated_at: 10.minutes.ago) } 
      before do
          fill_in "Phrase",  with: dup_phrase
      end 
      it "a buzzword is not updated if duplicate" do
         expect { click_button submit }.not_to change{
                   Buzzword.find_by_id(buzzword_orig).updated_at 
                 }
      end
      it_should_behave_like "maint_page_with_error", page_id_css_tag,
                                                  page_id_string,
                                    "Phrase has already been taken"
   end # no duplicates  
   
   describe "does not allow blanks"  do
     before {fill_in :phrase, with: nil}
      it "a buzzword is not updated if blank" do
        expect { click_button submit }.not_to change{
                 Buzzword.find_by_id(buzzword).updated_at } 
      end
      it_should_behave_like "maint_page_with_error", page_id_css_tag,
                                                  page_id_string,
                                                  "Phrase can't be blank" 
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
		it_should_behave_like "maint_page_with_error", page_id_css_tag,
                                                  page_id_string,
                                                  "Phrase is too long"
   end # does not allow too long 

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
