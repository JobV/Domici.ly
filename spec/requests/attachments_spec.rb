require 'rails_helper'

RSpec.describe "Attachments", :type => :request do
  describe "GET /attachments" do
    it "works! (now write some real specs)" do
      get attachments_path
      expect(response.status).to be(200)
    end
  end
end
