shared_examples "add_page_with_error" do
 describe "after submission" do
      before do 
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
end
