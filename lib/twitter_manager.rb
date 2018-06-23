require "twitter"

module QuickAlertJp
  class TwitterManager
    def self.setup
      @@client = Twitter::Streaming::Client.new do |config|
        config.consumer_key = ENV["TW_CUS_KEY"]
        config.consumer_secret = ENV["TW_CUS_SEC"]
        config.access_token = ENV["TW_ATK_KEY"]
        config.access_token_secret = ENV["TW_ATK_SEC"]
      end
    end

    def self.watch(follow, &block)
      raise ArgumentError, "No set block for callback." unless block_given?
      @@client.filter(follow: follow.join(",")) do |object|
        if object.is_a?(Twitter::Tweet)
          block.call(object.text)
        end
      end
    end
  end
end
