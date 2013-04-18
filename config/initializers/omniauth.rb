Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, 'hmVVzdmxRRQ3nGQkc15x7w', '5PvM2BsNDPAkLgTEc997fk8LwKJOajj2XvO31rdLNNs'
end