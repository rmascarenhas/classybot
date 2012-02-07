require_relative '../lib/classybot'

db = ClassyBot::Storage.powerful_storage_system

unless db.table_exists? 'jokes'
  db.create_table :jokes do
    primary_key :id
    String :text
  end
end
