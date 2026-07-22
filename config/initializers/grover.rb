Grover.configure do |config|
  node_bin = ENV["NODE_BIN_PATH"].presence
  config.node_env_vars = {
    "PATH" => [node_bin, ENV["PATH"]].compact.join(File::PATH_SEPARATOR)
  }
  config.use_pdf_middleware = true
  config.options = {
    print_background: true,
    format: "A4",
    full_page: true,
    prefer_css_page_size: false,
    emulate_media: "screen",
    cache: false,
    timeout: 0,
    launch_args: %w[--font-render-hinting=medium --no-sandbox],
    margin: { top: "10px", right: "10px", bottom: "10px", left: "10px" },
    scale: 0.85
  }
end
