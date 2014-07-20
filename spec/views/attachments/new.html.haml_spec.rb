require 'rails_helper'

RSpec.describe "attachments/new", :type => :view do
  before(:each) do
    assign(:attachment, Attachment.new(
      :alert_id => 1,
      :attachment => "MyString"
    ))
  end

  it "renders new attachment form" do
    render

    assert_select "form[action=?][method=?]", attachments_path, "post" do

      assert_select "input#attachment_alert_id[name=?]", "attachment[alert_id]"

      assert_select "input#attachment_attachment[name=?]", "attachment[attachment]"
    end
  end
end
