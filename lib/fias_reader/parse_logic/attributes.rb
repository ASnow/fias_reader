module FiasReader
  module ParseLogic
    module Attributes
      include FiasReader::ParseLogic::Abstract

      def attr(name, value)
        @row[name] = value if @row
        super
      end
    end
  end
end
