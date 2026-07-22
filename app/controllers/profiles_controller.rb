class ProfilesController < ApplicationController
  def show
  end

  def download
    send_file("public/profile.pdf")
  end

  def compile
    return incorrect_key if ENV["COMPILE_KEY"].blank?
    return incorrect_key unless ActiveSupport::SecurityUtils.secure_compare(
      params[:key].to_s, ENV["COMPILE_KEY"]
    )

    html = render_to_string(
      "profiles/compile", layout: "compile", formats: [:html]
    )

    pdf = Grover.new(html, format: "A4").to_pdf
    File.binwrite(Rails.root.join("public/profile.pdf"), pdf)

    redirect_to root_path, flash: { success: "Recompiled" }
  end

  private

  def incorrect_key
    redirect_to root_path, flash: { error: "Incorrect key" }
  end
end
