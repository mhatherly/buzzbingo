shared_examples "maint_page_with_error" do |page_id_css_tag, 
                                          page_id_string,
                                          error_msg|
 describe "after submission" do
      before do 
       click_button submit 
      end
      it "should be on the #{page_id_string} page" do
        page.should have_css(page_id_css_tag, text: page_id_string)
      end  # right page
      
      it "should have an error message of some sort" do
       page.should have_content('error')
      end
      
      it "should have the correct error message" do
        page.should have_error_message(error_msg) 
      end
 end #after sub
end
