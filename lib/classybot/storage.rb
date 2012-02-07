module ClassyBot
  require 'sequel'

  # Deals with classybot's secret hidden memory source.
  # (don't tell anyone but it's just a database!)
  class Storage

    def self.powerful_storage_system
      Sequel.connect(connection_url)
    end

  private

    def self.connection_url
      ENV['DATABASE_URL']
    end
  end
end
