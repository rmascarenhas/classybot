require_relative '../lib/classybot'

luck = rand

if luck < 0.3
  ClassyBot::MessageSystem.tell_joke

elsif luck < 0.9
  ClassyBot::MessageSystem.say_something_interesting # fortunes
 
else
  ClassyBot::MessageSystem.rant

end
