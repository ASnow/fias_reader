module FiasReader
  # Инерфейс для работы XML с базой ФИАС
  class Scope
    attr_reader :options, :logics

    def initialize(table)
      @table = table
      @options = {}
      @logics = @table.class::LOGICS.dup
    end

    def all
      @options[:rows] = -> (row) { yield row }
      parse!
    end

    def first
      result = nil
      catch :fias_parse_stop do
        @options[:rows] = -> (row) do
          result = row
          throw :fias_parse_stop
        end
        parse!
      end
      result
    end

    def select(*args)
      index = @logics.index(FiasReader::ParseLogic::Attributes)
      @logics[index] = FiasReader::ParseLogic::AttributesSelect if index
      @options[:select] = args
      self
    end

    def parse!(parser = default_parser)
      Ox.sax_parse parser, @table.file, symbolize: true
    end

    def default_parser
      FiasReader::Parser.new(logics, @options)
    end

    # def logics
    #   @logics #+ [ParseLogic::Logger]
    # end
  end
end
