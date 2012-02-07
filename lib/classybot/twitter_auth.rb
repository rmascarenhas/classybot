require 'tweetstream'

Twitter.configure do |config|
  config.consumer_key       = ENV['CLASSYBOT_CONSUMER_KEY']
  config.consumer_secret    = ENV['CLASSYBOT_CONSUMER_SECRET']
  config.oauth_token        = ENV['CLASSYBOT_OAUTH_TOKEN']
  config.oauth_token_secret = ENV['CLASSYBOT_OAUTH_TOKEN_SECRET']
end

TweetStream.configure do |config|
  config.consumer_key       = ENV['CLASSYBOT_CONSUMER_KEY']
  config.consumer_secret    = ENV['CLASSYBOT_CONSUMER_SECRET']
  config.oauth_token        = ENV['CLASSYBOT_OAUTH_TOKEN']
  config.oauth_token_secret = ENV['CLASSYBOT_OAUTH_TOKEN_SECRET']
  config.auth_method        = :oauth
  config.parser             = :json_gem
end
