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

  describe "POST /compile" do
    subject { post "/profiles/compile", params: params }

    let(:params) { { key: "secret" } }

    before do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with("COMPILE_KEY").and_return(compile_key)
      allow(Grover).to receive(:new).and_return(instance_double(Grover, to_pdf: "PDF-BYTES"))
      allow(File).to receive(:binwrite)
    end

    context "with the correct key" do
      let(:compile_key) { "secret" }

      it "writes the PDF and redirects with a success flash" do
        subject

        expect(File).to have_received(:binwrite).with(
          Rails.root.join("public/profile.pdf"), "PDF-BYTES"
        )
        expect(response).to redirect_to(root_path)
        expect(flash[:success]).to eq("Recompiled")
      end
    end

    context "with an incorrect key" do
      let(:compile_key) { "secret" }
      let(:params) { { key: "wrong" } }

      it "does not write the PDF and redirects with an error flash" do
        subject

        expect(File).not_to have_received(:binwrite)
        expect(response).to redirect_to(root_path)
        expect(flash[:error]).to eq("Incorrect key")
      end
    end

    context "when COMPILE_KEY is not set" do
      let(:compile_key) { nil }

      it "rejects any key and redirects with an error flash" do
        subject

        expect(File).not_to have_received(:binwrite)
        expect(response).to redirect_to(root_path)
        expect(flash[:error]).to eq("Incorrect key")
      end
    end
  end
end
