require 'rails_helper'

RSpec.describe "Neighborhoods", :type => :request do
  describe "GET /neighborhoods" do
    it "works! (now write some real specs)" do
      get neighborhoods_path
      expect(response.status).to be(200)
    end
  end
end