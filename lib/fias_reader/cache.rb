module FiasReader
  module Cache
    FILE = '/tmp/fias_reader_cache.db'.freeze

    def init(reader)
      reindex = true unless File.exist?(FILE)

      DataMapper.setup(:default, "sqlite://#{FILE}")
      begin
        DataMapper.auto_upgrade!
      rescue
        nil
      end
      adapter = DataMapper.repository(:default).adapter
      adapter.execute('PRAGMA journal_mode=OFF; PRAGMA synchronous=OFF; PRAGMA locking_mode = EXCLUSIVE; PRAGMA count_changes = OFF; PRAGMA cache_size=500000; PRAGMA temp_store = MEMORY; PRAGMA auto_vacuum = NONE;')
      index_build(reader) if reindex
    end

    def clear
      File.delete(FILE)
    end

    def index_build(reader)
      adapter = DataMapper.repository(:default).adapter
      adapter.execute('BEGIN;')
      puts "Индексируем части адресов..."
      FiasReader::Cache::AddressPart.index reader
      puts "Индексируем уровни адресов..."
      adapter.execute('CREATE INDEX `aolevel_index` ON `fias_reader_cache_address_parts` (`aolevel` );')
      puts "Индексируем структуру частеи адресов..."
      FiasReader::Cache::AddressPart.index_levels
      puts "Индексирование закончено..."
      adapter.execute('COMMIT;')
    end

    module_function :init, :clear, :index_build
  end
end
