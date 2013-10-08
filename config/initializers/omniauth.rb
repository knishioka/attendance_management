omniauth_config = YAML::load(File.read("config/omniauth.yml"))
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, omniauth_config['github_key'], omniauth_config['github_secret'], scope: "user"
  provider :bitbucket, omniauth_config['bitbucket_key'], omniauth_config['bitbucket_secret']
end