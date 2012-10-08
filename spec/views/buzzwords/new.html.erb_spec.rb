require 'spec_helper'

describe "buzzwords/new" do
  before(:each) do
    assign(:buzzword, stub_model(Buzzword,
      :phrase => "MyString"
    ).as_new_record)
  end

  it "renders new buzzword form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => buzzwords_path, :method => "post" do
      assert_select "input#buzzword_phrase", :name => "buzzword[phrase]"
    end
  end
end
