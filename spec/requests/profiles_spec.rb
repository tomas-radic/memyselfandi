require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  describe "GET /show" do
    subject { get "/profiles/show" }

    it "Renders template" do
      subject

      expect(response).to render_template(:show)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /download" do
    subject { get "/profiles/download" }

    it "Sends file" do
      expect_any_instance_of(ProfilesController).to receive(:send_file).with('public/profile.pdf')

      subject
    end
  end
end
