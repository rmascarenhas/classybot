require_relative '../lib/classybot'

# Followers at the moment (retrieved using Twitter API) and followers
# in the local storage
followers_atm   = ClassyBot::Profile.followers
local_followers = ClassyBot::MemorySystem.remember(:followers)

# We've got new followers!
if followers_atm.size > local_followers.size
  new_followers = followers_atm - local_followers

  new_followers.each do |follower|
    ClassyBot::MessageSystem.message(follower, ClassyBot::MessageSystem.welcome_message)
    ClassyBot::MemorySystem.memorize(:followers, follower) # remember about the new follower

    ClassyBot::Profile.follow(follower) # follow back
  end
end
