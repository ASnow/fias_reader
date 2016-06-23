module FiasReader
  # Инерфейс для работы XML с базой ФИАС
  class Reader
    attr_reader :path
    def initialize(path)
      @path = path
    end

    # Итерируем по всем активным записям домов, принимает блок в качестве аргумента
    # В вызываемы блок передается объект типа FiasReader::Reader::Row.
    XML_DATE_SEPARATOR = '-'.freeze
    EMPTY_STRING = '0'.freeze
    TODAY = Date.today.strftime('%Y0%m0%d').to_i
    def each
      Cache.init self

      Table::House.new(self).query.all do |row|
        next unless active?(row)
        row = FiasReader::Reader::Row.new row
        yield row if row.address_object
      end
    end

    private

    def active?(row)
      date_to_int(row[:ENDDATE]) >= TODAY && date_to_int(row[:STARTDATE]) < TODAY
    end

    def date_to_int(date)
      date.tr!(XML_DATE_SEPARATOR, EMPTY_STRING)
      date.to_i
    end
  end
end
