require 'rails_helper'

RSpec.describe "attachments/edit", :type => :view do
  before(:each) do
    @attachment = assign(:attachment, Attachment.create!(
      :alert_id => 1,
      :attachment => "MyString"
    ))
  end

  it "renders the edit attachment form" do
    render

    assert_select "form[action=?][method=?]", attachment_path(@attachment), "post" do

      assert_select "input#attachment_alert_id[name=?]", "attachment[alert_id]"

      assert_select "input#attachment_attachment[name=?]", "attachment[attachment]"
    end
  end
end
