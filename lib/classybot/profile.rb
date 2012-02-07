module ClassyBot

  # Class who actually deals with classybot's profile on
  # Twitter, using its API.
  #
  # In any place that a follower is a method parameter, a Hash in the
  # form
  #
  #     { twitter_id: 443, username: "foobar" }
  #
  # is expected.

  require 'twitter'
  require_relative 'twitter_auth'

  class Profile

    def self.followers
      return @followers unless @followers.nil?

      @bot_id = Twitter.user('classy_bot').id

      fetch_followers_ids

      @followers = []
      @bot_follower_ids.each do |id|
        followers << { twitter_id: id, username: Twitter.user(id).screen_name }
      end

      @followers  
    end

    def self.follow(follower)
      Twitter.follow(follower[:twitter_id]) {}
    end

  private

    def self.fetch_followers_ids
      @bot_follower_ids = []
      cursor = -1

      while cursor != 0
        bot_followers = Twitter.follower_ids(@bot_id, cursor: cursor)
        cursor = bot_followers.next_cursor

        @bot_follower_ids += bot_followers.ids
        
        # be nice with Twitter
        sleep(2)
      end
    end

  end

end
