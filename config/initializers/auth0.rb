Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    Rails.application.secrets.auth0_app_id,
    Rails.application.secrets.auth0_app_secret,
    Rails.application.secrets.auth0_app_endpoint,
    callback_path: "/auth/auth0/callback"
  )
end
