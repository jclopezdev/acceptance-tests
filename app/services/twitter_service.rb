class TwitterService
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV.fetch('TWITTER_CONSUMER_KEY')
      config.consumer_secret = ENV.fetch('TWITTER_CONSUMER_SECRET')
      config.access_token = ENV.fetch('TWITTER_ACCESS_TOKEN')
      config.access_token_secret = ENV.fetch('TWITTER_TOKEN_SECRET')
    end
  end

  def tweet(message)
    @client.update(message)
    true
  end
end
