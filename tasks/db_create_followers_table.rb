require_relative '../lib/classybot'

db = ClassyBot::Storage.powerful_storage_system

unless db.table_exists? 'followers'
  db.create_table :followers do
    primary_key :id 
    Integer :twitter_id
    String :username
  end
end
