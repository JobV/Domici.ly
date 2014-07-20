require 'rails_helper'

RSpec.describe "attachments/show", :type => :view do
  before(:each) do
    @attachment = assign(:attachment, Attachment.create!(
      :alert_id => 1,
      :attachment => "Attachment"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Attachment/)
  end
end
