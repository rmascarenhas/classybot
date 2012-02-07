module ClassyBot

  # This class is able to send messages using the Twitter API.
  # It can send both messages to a specific user and a normal tweet.

  class MessageSystem

    # User is expected to be a hash (as in any other place a user is manipulated)
    # like:
    #     { :twitter_id => 999, :username => "classybotfoo" }
    def self.message(user, message, options = {})
      tweet "@#{user[:username]} #{message}", options
    end

    # Returns a random welcome message
    def self.welcome_message
      pick(WELCOME_MESSAGES)
    end

    def self.tell_joke(screen_name = "", options = {})
      jokes = MemorySystem.remember(:jokes).map { |j| j[:text] }
      tweet screen_name + pick(jokes), options
    end

    def self.say_something_interesting(screen_name = "", options = {}) # fortune cookies
      cookies = MemorySystem.remember(:fortunes).map { |c| c[:text] }
      tweet screen_name + pick(cookies), options
    end

    def self.rant(screen_name = "", options = {})
      tweet screen_name + pick(RANTS), options
    end

    def self.tgif
      tweet_with_media pick(TGIF), pick(IMAGES)
    end

  private
  
    def self.tweet(message, options = {})
      Twitter.update message, options
      sleep(2) # classybot is such a gentle bot
    end

    def self.tweet_with_media(message, image, options = {})
      Twitter.update_with_media(message, File.open(image), options)
      sleep(2)
    end

    def self.pick(arr)
      arr[rand(arr.size)]
    end

  end

end
