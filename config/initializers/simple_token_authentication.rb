SimpleTokenAuthentication.configure do |config|
  config.identifiers = { user: :username }
  config.header_names = { user: { authentication_token: 'X-User-Token', username: 'X-User-Usarname' } }
end