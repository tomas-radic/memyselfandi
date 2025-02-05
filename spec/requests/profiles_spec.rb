require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  describe "GET /show" do
    subject { get "/profiles/show" }

    it "Returns http success" do
      subject

      expect(response).to render_template(:show)
      expect(response).to have_http_status(:success)
    end
  end
end
