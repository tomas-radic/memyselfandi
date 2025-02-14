class ProfilesController < ApplicationController

  def show
  end

  def download
    send_file("public/profile.pdf")
  end

  def compile
    html = render_to_string(
      "profiles/compile", layout: "compile", formats: [:html]
    )

    pdf = Grover.new(html, format: "A4").to_pdf

    respond_to do |format|
      format.html { render html: html }
      format.pdf { send_data pdf, filename: "tomas-radic.pdf", type: "application/pdf" }
    end
  end
end
