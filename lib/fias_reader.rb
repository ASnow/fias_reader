require 'fias_reader/version'

require 'date'
require 'sqlite3'
require 'ox'
require 'data_mapper'
require 'dm-migrations'
require 'dm-types'
begin
  require 'pry'
rescue
  nil
end
require 'active_support/all'
require 'fias_reader/parse_logic/abstract'
require 'fias_reader/parse_logic/attributes'
require 'fias_reader/parse_logic/attributes_select'
require 'fias_reader/parse_logic/depth'
require 'fias_reader/parse_logic/logger'
require 'fias_reader/parse_logic/rows'
require 'fias_reader/parse_logic/stub'
require 'fias_reader/parse_logic'
require 'fias_reader/parser'
require 'fias_reader/scope'
require 'fias_reader/cache'
require 'fias_reader/cache/guid'
require 'fias_reader/cache/address_part/level_adapter'
require 'fias_reader/cache/address_part'
require 'fias_reader/table'
require 'fias_reader/table/house'
require 'fias_reader/table/address_part'

require 'fias_reader/reader/row'
require 'fias_reader/reader'

module FiasReader
  # Создаем инстанс ФИАС базы. Параметр путь до файлов базы
  def self.open(path)
    FiasReader::Reader.new path
  end
end
