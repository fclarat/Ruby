OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '16785608480-f1n8nneo9kb6vlad8o26no42flve1rbl.apps.googleusercontent.com', 'mpbWAULUHLEZ-gAiSsiTwKhY', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '648992315277559', '40821205c016d032c1c95b6a18ae60ba', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end