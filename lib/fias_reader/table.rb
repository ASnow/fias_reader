module FiasReader
  # Инерфейс для работы XML с базой ФИАС
  class Table
    LOGICS = [
      ParseLogic::Depth,
      ParseLogic::Rows,
      ParseLogic::Attributes
    ].freeze
    def initialize(reader)
      @reader = reader
    end

    def query
      FiasReader::Scope.new(self)
    end

    def file
      File.new(file_path, 'r')
    end

    def file_path
      Dir[
        "#{@reader.path}/#{self.class::File}_*.XML",
        "#{@reader.path}/#{self.class::File}_*.xml"
      ].first
    end
  end
end
