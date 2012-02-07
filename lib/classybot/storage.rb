module ClassyBot
  require 'yaml'
  require 'sequel'

  # Deals with classybot's secret hidden memory source.
  # (don't tell anyone but it's just a database!)
  class Storage

    def self.powerful_storage_system
      Sequel.connect(connection_url)
    end

  private

    def self.connection_url
      options = YAML.load_file(ClassyBot.root + '/classybot_config.yml')['classybot']

      adapter   = options['adapter']                               || DEFAULTS[:adapter]
      username  = options['username']                              || DEFAULTS[:username]
      password  = options['password'] ? (':' + options[:password])  : DEFAULTS[:password]
      host      = options['host']                                  || DEFAULTS[:host]
      database  = options['database']                              || DEFAULTS[:database]

      "#{adapter}://#{username}#{password}@#{host}/#{database}"
    end
  end
end
