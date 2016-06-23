module FiasReader
  module ParseLogic
    module AttributesSelect
      include FiasReader::ParseLogic::Abstract

      def attr(name, value)
        @row[name] = value if @row && @options[:select].include?(name)
        super
      end
    end
  end
end
