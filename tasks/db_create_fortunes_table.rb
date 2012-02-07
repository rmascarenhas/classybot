require_relative '../lib/classybot'

db = ClassyBot::Storage.powerful_storage_system

unless db.table_exists? 'fortunes'
  db.create_table :fortunes do
    primary_key :id 
    String :text
  end
end
