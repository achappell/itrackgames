OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'xvqB61RpJ7jQyIrGNQ', 'nmgnTjRnAi6JLs4nu6IXVMVoWSudG3vFPcy24yznoN8'
end