module ClassyBot

  # ClassyBot super powerful memory system, capable of remembering
  # even the most difficult to remember things!
  class MemorySystem

    # Inserts the data in the given table (+section+ parameter).
    # Assumes the data is properly formated as a hash to the
    # target table.
    def self.memorize(section, data)
      table = table_named(section)

      case data
        when Array
          data.each { |row|
            table.insert(row)
          }
        when Hash
          table.insert(data)
      end
    end

    # Retrieves all the information of the given section (database table)
    # applying the +filters+ passed, if any.
    def self.remember(section, filters = {})
      table = table_named(section)

      table.filter(filters).all
    end

  private

    def self.table_named(name)
      db = Storage.powerful_storage_system
      db[name]
    end
  end
end
