Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"],
    {
      name: "google",
      scope: "email, profile, plus.me, http://gdata.youtube.com",
      prompt: "select_account"
    }

    # {
    #   scope: "email, profile, userinfo.email, state"
    #   # provider_ignores_state: true # this introduces csrf problems (https://github.com/intridea/omniauth-oauth2/issues/58)
    # }
end


# to auth, hit:
#   http://localhost:3000/users/auth/google_oauth2
#   http://<domain>/users/auth/google_oauth2
# will redirect to:
#   http://localhost:3000/users/auth/google_oauth2/callback 
#   http://<domain>/users/auth/google_oauth2/callback