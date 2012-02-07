require_relative 'classybot/utils'
require_relative 'classybot/storage'
require_relative 'classybot/memory_system'
require_relative 'classybot/url_fetcher'
require_relative 'classybot/profile'
require_relative 'classybot/message_system'
require_relative 'classybot/trainee'

module ClassyBot

  def self.run!
    TweetStream.track(Trainee.get_my_messages) do |status|
      Trainee.read_this_and_do_what_you_think_its_best(status.text, status)
    end
  end

  ['INT', 'TERM'].each do |sig|
    trap(sig) { puts 'Bye.'; exit 0 }
  end

end
