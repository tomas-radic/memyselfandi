require "base64"

module ProfilesHelper
  # Inlines a compiled stylesheet as a <style> block. Grover renders an HTML
  # string with no origin, so linked /assets/* stylesheets can't be fetched;
  # embedding the CSS keeps the generated PDF styled.
  def inline_stylesheet(logical_name)
    asset = Rails.application.assets[logical_name]
    return "".html_safe unless asset

    content_tag(:style, asset.to_s.html_safe)
  end

  # Renders an image. When +inline+ is true (PDF compilation), the asset is
  # embedded as a base64 data URI so it resolves without an /assets/* request.
  def profile_image_tag(logical_name, inline: false, **options)
    return image_tag(logical_name, **options) unless inline

    asset = Rails.application.assets[logical_name]
    data_uri = "data:#{asset.content_type};base64,#{Base64.strict_encode64(asset.to_s)}"
    image_tag(data_uri, **options)
  end
end
