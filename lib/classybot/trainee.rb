module ClassyBot

  # ClassyBot is so classy that he has his own dedicated trainee, that do
  # the hard stuff in his behalf. It gets messages that might interest ClassyBot,
  # tries to understand them and send the appropriate reply for the sender.

  class Trainee

    JOKE_REQUESTS = [
      '@classy_bot make me laugh',
      '@classy_bot tell me a joke',
      '@classy_bot i wanna laugh',
      "@classy_bot i'm bored",
      '@classy_bot be fun'
    ]

    FORTUNE_REQUESTS = [
      '@classy_bot tell me something interesting',
      '@classy_bot share a piece of your knowledge',
      '@classy_bot make me think',
      '@classy_bot fortune cookie'
    ]

    RANT_REQUESTS = [
      '@classy_bot whasup',
      '@classy_bot what are you doing?',
      '@classy_bot whats new?',
      '@classy_bot what are you doing?',
      '@classy_bot rant a bit',
      '@classy_bot ruby is cool'
    ]


    # Here we have the messages that are interesting to classybot. It might be
    # a Ruby expression to be evaluated, a question of some kind, or a command.
    # Avaliable commands:
    #
    #   any sentence in the JOKE_REQUESTS array
    #     => trainee will send a joke to the sender.
    #
    #   any sentence in the FORTUNE_REQUESTS array
    #     => trainee will send a fortune cookie
    #
    #   any sentence in the RANT_REQUESTS array
    #     => trainee will send a rant
    def self.get_my_messages
      JOKE_REQUESTS + FORTUNE_REQUESTS + RANT_REQUESTS
    end

    def self.read_this_and_do_what_you_think_its_best(message, status)
      username = "@#{status.user.screen_name} "

      if JOKE_REQUESTS.include?(message)
        MessageSystem.tell_joke username, :in_reply_to_status_id => status.id

      elsif FORTUNE_REQUESTS.include?(message)
        MessageSystem.say_something_interesting username, :in_reply_to_status_id => status.id

      elsif RANT_REQUESTS.include?(message)
        MessageSystem.rant username, :in_reply_to_status_id => status.id

      else
        send_sorry_message(status)

      end
    rescue
      send_sorry_message(status)
    end

    # Message sent when the trainee doesn't know what to do with a certain message,
    # or when an exception is raised.
    def self.send_sorry_message(status)
      user = { :twitter_id => status.user.id_str.to_i, :username => status.user.screen_name }
      MessageSystem.message(user, 'Wat?', status)
    end
  
  end

end
