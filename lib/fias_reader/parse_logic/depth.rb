module FiasReader
  module ParseLogic
    module Depth
      include FiasReader::ParseLogic::Abstract

      def initialize(options)
        @depth = 0
        super
      end

      def start_element(name)
        @depth += 1
        super
      end

      def end_element(name)
        @depth -= 1
        super
      end
    end
  end
end
