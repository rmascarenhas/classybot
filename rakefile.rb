# Classybot's classy Rakefile

require_relative 'lib/classybot'

namespace :db do

  # Files starting with +db_+ at the +tasks/+ directory are expected to setup the database.
  # The files are executed in alphabetical order, so it is recommended
  # that db files have a preceding timestamp.
  desc 'Creates tables used by classybot'
  task :migrate do
    db_files = Dir.glob('tasks/db_*.rb').sort
    
    db_files.each { |f| require_relative f }
  end

  desc 'Populates the database with jokes from twitlol.com'
  task :joke do
    ClassyBot::UrlFetcher.fetch('http://twitlol.com/favs') do
      xpath %q{//div[@class = "bubble"]/p/span/a}
      param 'page', :range => 1..100
      section :jokes
    end
  end

  desc 'Fetches classybot followers and inserts them in the database.'
  task :followers do
    ClassyBot::MemorySystem.memorize(:followers, ClassyBot::Profile.followers)
  end

  desc 'Fetches some fortune cookies (from the fortune Unix command) from www.coe.neu.edu'
  task :fortunes do
    ClassyBot::UrlFetcher.fetch('http://www.coe.neu.edu/cgi-bin/fortune') do
      xpath "//pre"
      repeat 150
      section :fortunes
    end
  end

  desc 'Populates the database with jokes, followers and fortunes'
  task :populate => [:joke, :followers, :fortunes] {}

end


desc 'Checks for new followers, sending a welcome message'
task :check_new_followers do
  require_relative 'cron/check_new_followers'
end

desc 'Tweets a bit'
task :talk do
  require_relative 'cron/talk'
end

desc 'Is it Friday yet?'
task :tgif do
  require_relative 'cron/tgif'
end
