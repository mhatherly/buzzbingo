require 'spec_helper'

describe "buzzwords/edit" do
  before(:each) do
    @buzzword = assign(:buzzword, stub_model(Buzzword,
      :phrase => "MyString"
    ))
  end

  it "renders the edit buzzword form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => buzzwords_path(@buzzword), :method => "post" do
      assert_select "input#buzzword_phrase", :name => "buzzword[phrase]"
    end
  end
end
